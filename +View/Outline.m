classdef (Abstract) Outline


methods (Static)


function img = default ( outline, bg_img )
% Display an outline on top of an image.
% Use default configuration
	img = View.Outline.polygon( outline, bg_img, 1, 'red' );
end


function img = polygon ( outline, bg_img, linewidth, color )
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
