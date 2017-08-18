classdef (Abstract) Rectangle


methods (Static)


function img = default ( rect, bg_img )
% Use a 3px red boundary and a 50% white fill by default.
	img = View.Rectangle.fill( rect, bg_img, 'white', 0.5 );
	img = View.Rectangle.boundary( rect, img, 3, 'red' );
end


function img = boundary ( rect, bg_img, linewidth, color )
	poly = transpose( rect );
	img = insertShape( bg_img ...
		, 'Polygon', reshape( poly, 1, [] ) ...
		, 'LineWidth', linewidth ...
		, 'Color', color ...
		, 'Opacity', 1 ...
		);
end


function img = fill ( rect, bg_img, color, opacity )
	poly = transpose( rect );
	img = insertShape( bg_img ...
		, 'FilledPolygon', reshape( poly, 1, [] ) ...
		, 'Color', color ...
		, 'Opacity', opacity ...
		);
end


end % methods


end
