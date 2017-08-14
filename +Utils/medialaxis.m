function [ centers, radius, triangles ] = medialaxis( boundary )
% Returns the medial axis corresponding to the given boundary.
%
% Syntax #####################
%
% [ centers, radius, triangles ] = Compute.medialaxis( boundary )
%
% Description ################
%
% boundary: 2 x N array. N is the number of points in the boundary.
% centers: 2 x M array. The interior points of the medial axis.
% radius: 1 x M row vector. The cercle radius of each interior medial axis point (centers).
% triangles: 3 x M array. The interior Delaunay triangles.


% Get the boundary in a complex form to ease the computations
bnd = boundary(1,:) + 1i * boundary(2,:);


% Compute the delaunay triangulation of the boundary.
% triangles is of size (3,n)
% !!! temporary deactivation of warning
% Normally we should take care of the duplicate points
warning( 'off', 'all' );
triangles = sort( transpose( delaunay( real(bnd), imag(bnd) ) ) );
warning( 'on', 'all' );


% Retrieve each point of the triangles into a separate variable.
% triangles are named ABC (each letter being a point of a triangle).
A = bnd( triangles(1,:) );
B = bnd( triangles(2,:) );
C = bnd( triangles(3,:) );


% Let also be a, b and c the sides opposite to points A, B and C
a = C-B;
b = A-C;
c = B-A;


% dotcross is a complex number such that dotcross = (a|b) + i*det(a,b)
dotcross = a .* conj( b );


% Compute the centers of the circumcercles of the ABC triangles.
centers = ( A+B + 1i*c.*real(dotcross)./imag(dotcross) ) / 2;


% Compute the radius of the circumcercles.
radius = abs( A - centers );


% Find interior points.
% Only works if oulining counter clockwise
% interior = imag( dotcross ) > 0;
% Alternative method (more computing intensive)
centers = [ real( centers ); imag( centers ) ];
interior = inpolygon( centers(1,:), centers(2,:), boundary(1,:), boundary(2,:) );


% Keep only interior points
centers = centers( :, interior );
radius = radius( interior );
triangles = triangles( :, interior );


end
