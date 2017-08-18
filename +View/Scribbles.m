classdef (Abstract) Scribbles


methods (Static)


function img = default ( visible_scribbles, bg_img )
% Display green foreground and red background scribbles on top of an image.
	img = View.Scribbles.fgPoints( visible_scribbles, bg_img, 3, 'green' );
	img = View.Scribbles.bgPoints( visible_scribbles, img, 3, 'red' );
end


function img = fgPoints ( visible_scribbles, bg_img, radius, color )
	[ ~, fg_scribbles ] = Resources.Scribbles.split( visible_scribbles );
	nb_points = size( fg_scribbles, 1 );
	disks = [ fg_scribbles, repmat( radius, nb_points, 1 ) ];
	img = insertShape( bg_img ...
		, 'FilledCircle', disks ...
		, 'Color', color ...
		, 'Opacity', 1 ...
		);
end


function img = bgPoints ( visible_scribbles, bg_img, radius, color )
	[ bg_scribbles, ~ ] = Resources.Scribbles.split( visible_scribbles );
	nb_points = size( bg_scribbles, 1 );
	disks = [ bg_scribbles, repmat( radius, nb_points, 1 ) ];
	img = insertShape( bg_img ...
		, 'FilledCircle', disks ...
		, 'Color', color ...
		, 'Opacity', 1 ...
		);
end


end % methods


end
