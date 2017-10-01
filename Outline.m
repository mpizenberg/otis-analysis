classdef (Abstract) Outline
% Manipulation of outline annotations.
% In all these functions, the first `outline` argument
% is an N x 2 array coming from json annotations.


methods (Static, Access = private)


function sliced = slice ( segment, max_distance )
% Slice a segment such that distance between intermediate points
% is under max_distance.
% segment = [ x1 y1; x2 y2 ]
	distance = norm( segment(1,:) - segment(2,:) );
	nb_segments = ceil( distance / max_distance );
	x_sliced = linspace( segment(1,1), segment(2,1), nb_segments+1 );
	y_sliced = linspace( segment(1,2), segment(2,2), nb_segments+1 );
	sliced = transpose( [ x_sliced; y_sliced ] );
end


end % private methods


methods (Static)


function mask = fgMask ( outline, mask_size )
% Generate a logical mask with true inside the outline area.
	mask = poly2mask( outline(:,1), outline(:,2), mask_size(1), mask_size(2) );
end


function mask = bgMask ( outline, mask_size )
% Generate a logical mask with true outside the outline area.
	mask = ~ Outline.fgMask( outline, mask_size );
end


function mask = fgEroded ( outline, radius, mask_size )
% Compute the eroded foreground mask of an outline.
	fg = Outline.fgMask( outline, mask_size );
	mask = imerode( fg, strel( 'disk', radius, 8 ) );
end


function mask = fgErodedSP ( outline, radius, superpixels )
% Compute the eroded foreground mask of an outline.
% Extend with superpixels.
	mask_size = size( superpixels );
	fg_eroded = Outline.fgEroded( outline, radius, mask_size );
	[ sp_ids, ~ ] = SP.fromMask( superpixels, fg_eroded );
	fg_mask = Outline.fgMask( outline, mask_size );
	mask = SP.constrainedMask( superpixels, sp_ids, fg_mask );
end


function max_radius = maxRadius ( outline )
% Compute the max radius of inner medial axis circles.
	[ ~, radius, ~ ] = Utils.medialaxis( transpose( outline ) );
	max_radius = max( radius );
end


function new_outline = regularize ( outline, max_distance )
% Add points in the outline such that there are no successive points
% farther than max_distance from each other.
	nb_points = size( outline, 1 );
	outline_closed = [ outline; outline(1,:) ];
	outline_sliced = cell( nb_points, 1 );
	for i = 1:nb_points
		sliced = Outline.slice( outline_closed(i:i+1,:), max_distance );
		outline_sliced{i} = sliced( 1:end-1, : );
	end
	new_outline = cell2mat( outline_sliced );
end


function skel = skeleton ( outline, radius_threshold )
% Compute the skeleton of an outline annotation.
% All circle centers with radius < radius_threshold are pruned.
% skel: 2 x M array. The skeleton points.
	[ centers, radius, ~ ] = Utils.medialaxis( transpose( outline ) );
	skel = centers( :, radius >= radius_threshold );
end


function mask = skeletonMask ( outline, radius_threshold, mask_size )
% Compute the skeleton and transform it into a binary mask.
	skeleton_sub = round( Outline.skeleton( outline, radius_threshold ) );
	mask = Utils.sub2mask( mask_size, skeleton_sub(2,:), skeleton_sub(1,:) );
end


function mask = skeletonSP ( outline, radius_threshold, superpixels )
% Compute the skeleton of an outline and extend with superpixels.
	skeleton = Outline.skeleton( outline, radius_threshold );
	[ sp_ids, ~ ] = SP.fromSub( ...
		superpixels, round(skeleton(2,:)), round(skeleton(1,:)) );
	fg_mask = Outline.fgMask( outline, size(superpixels) );
	mask = SP.constrainedMask( superpixels, sp_ids, fg_mask );
end


function outline_profile = profile ( outline, gt )
% Build the profile of an outline.
% The key functions are:
%     * bwdist: compute distance to nearest `true` pixel in logical image.
%     * improfile: compute profile along the given path.
% The tricky part is the fact that the outline can be outside of the image.
% So we crop a new area fitting exactly the outline bounding box.

	% Get the sizes of the mask and the bounding box of the outline.
	[ height, width ] = size( gt );
	bb_top = floor( min( outline(:,2) ) );
	bb_left = floor( min( outline(:,1) ) );
	bb_bottom = ceil( max( outline(:,2) ) );
	bb_right = ceil( max( outline(:,1) ) );


	% Adapt the groundtruth to fit the outline bounding box.
	% [   tl  |  t   |   tr  ]   [  0  |  0  |  0  ]
	% [----------------------]   [-----------------]
	% [   l   |  gt  |   r   ] = [  0  |  gt |  0  ]
	% [----------------------]   [-----------------]
	% [   bl  |  b   |   br  ]   [  0  |  0  |  0  ]
	t = max( 0, 1-bb_top );
	l = max( 0, 1-bb_left );
	b = max( 0, bb_bottom-height );
	r = max( 0, bb_right-width );

	gt_top = max( 1, bb_top );
	gt_left = max( 1, bb_left );
	gt_bottom = min( height, bb_bottom );
	gt_right = min( width, bb_right );
	gt_height = 1 + gt_bottom - gt_top;
	gt_width = 1 + gt_right - gt_left;

	gt_inside = gt( gt_top:gt_bottom, gt_left:gt_right );
	gt_fit = logical( ...
		[ zeros( t, l + gt_width + r ) ...
		; zeros( gt_height, l ), gt_inside , zeros( gt_height, r ) ...
		; zeros( b, l + gt_width + r ) ...
		]);


	% Change the outline coordinates to reflect the translation of (l,t).
	% Also close the outline polygon.
	outline_translated = ...
		[ outline(:,1) + l - gt_left, outline(:,2) + t - gt_top ];
	outline_closed = [ outline_translated ; outline_translated( 1, : ) ];


	% Compute inside and outside bwdist to have a signed distance to outline
	d_outside = bwdist( gt_fit );
	d_inside = bwdist( ~ gt_fit );
	dist_to_outline = d_outside - d_inside;


	% Finally compute the outline profile
	outline_profile = ...
		improfile( dist_to_outline, outline_closed(:,1), outline_closed(:,2) );


	% CAREFULL
	% improfile might generate very few NaN values (near the border)
	% So for now I will just filter out those values.
	outline_profile = outline_profile( ~( isnan( outline_profile ) ) );
end


function gs_radius = goldStandardRadius ( outline, gt )
	profile = Outline.profile( outline, gt );
	profile_mean = mean( profile );
	profile_std = std( profile );
	gs_radius = profile_mean + 2 * profile_std;
end


function [mask, time_gc, nIter] = grabcut ( image, outline, radius_threshold, superpixels, method, constraint)
% Compute the segmentation mask of an outline obtained with GrabCut

	mask_size = size( superpixels );
	fixed_bg = Outline.bgMask ( outline, mask_size );
	if strcmp(method,'skeleton')
		fixed_fg = Outline.skeletonSP ( outline, radius_threshold, superpixels );
	elseif strcmp(method,'erosion')
		fixed_fg = Outline.fgErodedSP ( outline, radius_threshold, superpixels );
	elseif strcmp(method, 'none')
		fixed_fg = [];
		constraint = 'none';
	end

	bg_constraint.type = 'hard';
	bg_constraint.mask = fixed_bg;
	fg_constraint.type = constraint;
	fg_constraint.mask = fixed_fg;

	t_start = tic;
	[ mask, nIter ] = GrabCut.segment( image, bg_constraint, fg_constraint );

	% Relaunch without FG initialization if it caused FG to collapse.
	if ~strcmp(constraint, 'none') && ~any( mask(:) )
		disp( 'FG collapsed, relaunching without FG initialization' );
		fg_constraint.type = 'none';
		[ mask, nIter ] = GrabCut.segment( imd, bg_constraint, fg_constraint );
	end
	time_gc = (tic - t_start) / 1e6;

end


end % methods


end
