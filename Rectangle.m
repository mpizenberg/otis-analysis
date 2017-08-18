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


end % methods


end
