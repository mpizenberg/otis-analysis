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


function [mask, time_gc, nIter] = grabcut ( image, rect, superpixels)
% Compute the segmentation mask obtained with GrabCut

	mask_size = size( superpixels );
	fixed_bg = Rectangle.bgMask ( rect, mask_size );
	fixed_fg = [];

	imd = double(image);
	[Beta, k, G, maxIter, diffThreshold] = GrabCut.grabcutParameters;

	% Call GrabCut (measure time and the number of iterations)
	tic
	[L,nIter] = GrabCut.GCAlgo(imd, fixed_bg, fixed_fg, k,G,maxIter, Beta, diffThreshold, []);
	time_gc = toc;
	mask = double(1-L);

end

end % methods


end
