classdef (Abstract) Rectangle
% Manipulation of bounding boxes annotations.
% In all these functions, the first `rect` argument
% is a 4 x 2 array coming from json annotations.


methods (Static)


function mask = fgMask ( rect, mask_size )
	mask = poly2mask( rect(:,1), rect(:,2), mask_size(1), mask_size(2) );
end


function mask = bgMask ( rect, mask_size )
	mask = ~ Rectangle.fgMask( rect, mask_size );
end


function [ mask, time_gc, nb_iter ] = grabcut ( image, rect, superpixels )
% Compute the segmentation mask obtained with GrabCut

	mask_size = size( superpixels );
	bg_constraint.type = 'hard';
	bg_constraint.mask = Rectangle.bgMask ( rect, mask_size );

	% Call GrabCut (measure time and the number of iterations)
	start_time = tic;
	[ mask, nb_iter ] = GrabCut.segment( image, bg_constraint );
	time_gc = tic - start_time;

end

end % methods


end
