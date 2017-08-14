classdef (Abstract) Skeleton


methods (Static)


function img = default ( skeleton, bg_img )
% Draw skeleton points with default green small disks.
	img = View.Skeleton.points( skeleton, bg_img, 1, 'green' );
end


function img = points ( skeleton, bg_img, radius, color )
% Draw disks of a given radius and color at each point of the skeleton.
	nb_points = size( skeleton, 2 );
	disks = transpose( [ skeleton; repmat( radius, 1, nb_points ) ] );
	img = insertShape( bg_img ...
		, 'FilledCircle', disks ...
		, 'Color', color ...
		, 'Opacity', 1 ...
		);
end


end % methods


end
