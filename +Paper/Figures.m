classdef (Abstract) Figures
% Contains methods generating visual figures of the paper.


properties (Constant)
	parula_colors = parula(6)
	colormap = [ 1 1 1; Paper.Figures.parula_colors( [1 5 3], : ) ]
end % constant properties


methods (Static, Access=private)


function eroded_mask = erodedMask( outline, mask_size )
% Compute the eroded mask from an outline.
	fg_mask = Outline.fgMask( outline, mask_size );
	max_radius = Outline.maxRadius( outline );
	erosion_disk = strel( 'disk', round( max_radius/2 ), 8 );
	eroded_mask = imerode( fg_mask, erosion_disk );
end


function img = coloredLayers( gt, fg_mask, outline, colormap )
% Generate an image, using different colors for
% the ground truth mask, some foreground mask, and the outline.
	labels = uint8( gt );
	labels( fg_mask ) = 2;
	img = ind2rgb( labels, colormap );
	img = View.Outline.points( outline, img, 2, colormap(4,:) );
end


function sp_mask = extendFrom( SP_ids, outline, mask_size, superpixels )
% Generate the mask obtained from some foreground superpixels indexes.
% Remove superpixels also belonging to the background.
	bg_mask = Outline.bgMask( outline, mask_size );
	[ SP_bg, ~ ] = SP.fromMask( superpixels, bg_mask );
	SP_conflicts = intersect( SP_ids, SP_bg );
	SP_ids = setdiff( SP_ids, SP_conflicts );
	sp_mask = SP.toMask( superpixels, SP_ids );
end


function img = addDisks( disks, bg_img )
% Add white/blue disks to represent BMA centers in figure 5.
	img = insertShape( bg_img ...
		, 'FilledCircle', disks ...
		, 'Color', 'white' ...
		, 'Opacity', 0.8 ...
		);
	img = insertShape( img ...
		, 'Circle', disks ...
		, 'LineWidth', 4 ...
		, 'Color', 'blue' ...
		, 'Opacity', 1 ...
		);
	disks_centers = [ disks(:,1:2), repmat(4,size(disks,1),1) ];
	img = insertShape( img ...
		, 'FilledCircle', disks_centers ...
		, 'Color', 'blue' ...
		, 'Opacity', 1 ...
		);
end


end % private methods


methods (Static)


% FIGURE 4: Foreground inferring methods #############################


function img = fgErosion ( gt, outline )
% Figure 4 a.
	eroded_mask = Paper.Figures.erodedMask( outline, size(gt) );
	img = Paper.Figures.coloredLayers( ...
		gt, eroded_mask, outline, Paper.Figures.colormap );
end


function img = fgErosionSP ( gt, outline, superpixels )
% Figure 4 c.
	eroded_mask = Paper.Figures.erodedMask( outline, size(gt) );
	[ SP_erosion, ~ ] = SP.fromMask( superpixels, eroded_mask );
	eroded_sp_mask = Paper.Figures.extendFrom( ...
		SP_erosion, outline, size(gt), superpixels );
	img = Paper.Figures.coloredLayers( ...
		gt, eroded_sp_mask, outline, Paper.Figures.colormap );
end


function img = fgSkeleton ( gt, outline )
% Figure 4 b.
	max_radius = Outline.maxRadius( outline );
	skeleton = Outline.skeleton( outline, 0.5*max_radius );
	colormap = Paper.Figures.colormap;
	img = ind2rgb( uint8( gt ), colormap(1:2,:) );
	img = View.Outline.points( outline, img, 2, colormap(4,:) );
	img = View.Skeleton.points( skeleton, img, 2, colormap(3,:) );
end


function img = fgSkeletonSP ( gt, outline, superpixels )
% Figure 4 d.
	max_radius = Outline.maxRadius( outline );
	skeleton = Outline.skeleton( outline, 0.5*max_radius );
	[ SP_skel, ~ ] = SP.fromSub( ...
		superpixels, round(skeleton(2,:)), round(skeleton(1,:)) );
	skeleton_sp_mask = Paper.Figures.extendFrom( ...
		SP_skel, outline, size(gt), superpixels );
	img = Paper.Figures.coloredLayers( ...
		gt, skeleton_sp_mask, outline, Paper.Figures.colormap );
end


% FIGURE 5: Blum medial axis #########################################


function img = bmaDisks ( outline, image )
% Figure 5 a.
	full_skeleton = Outline.skeleton( outline, 0 );
	disks = ...
		[ 185, 89, 58 ...
		; 267, 267, 20 ...
		; 265, 147, 10 ...
		];
	img = View.Skeleton.default( full_skeleton, image );
	img = View.Outline.default( outline, img );
	img = Paper.Figures.addDisks( disks, img );
end


function img = bmaDisksPruned ( outline, image )
% Figure 5 b.
	max_radius = Outline.maxRadius( outline );
	skeleton = Outline.skeleton( outline, 0.5 * max_radius );
	img = View.Skeleton.default( skeleton, image );
	img = View.Outline.default( outline, img );
	img = Paper.Figures.addDisks( [185, 89, 58], img );
end


end % methods


end
