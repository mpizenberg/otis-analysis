classdef (Abstract) Outline


methods (Static)


function img = default ( outline, bg_img )
% Display an outline on top of an image.
% Use default configuration
	img = View.Outline.points( outline, bg_img, 2, 'red' );
end


function img = points ( outline, bg_img, radius, color )
	nb_points = size( outline, 1 );
	disks = [ outline, repmat( radius, nb_points, 1 ) ];
	img = insertShape( bg_img ...
		, 'FilledCircle', disks ...
		, 'Color', color ...
		, 'Opacity', 1 ...
		);
end


function img = polygon ( outline, bg_img, linewidth, color )
% !!! When used with a line width > 1 it appears to be buggy.
	poly = transpose( outline );
	img = insertShape( bg_img ...
		, 'Polygon', reshape( poly, 1, [] ) ...
		, 'LineWidth', linewidth ...
		, 'Color', color ...
		, 'Opacity', 1 ...
		);
end


end % methods


end
