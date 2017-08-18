classdef (Abstract) Scribbles
% Manipulation of scribbles annotations.
% In all these functions, the first `scribbles` argument
% is an N x 2 array coming from json annotations.


methods (Static)


function mask = fgMask ( visible_scribbles, mask_size )
% Generate a logical mask with true for foreground scribbles points.
	[ ~, fg_scribbles ] = Resources.Scribbles.split( visible_scribbles );
	scribbles = round( fg_scribbles );
	mask = Utils.sub2mask( mask_size, scribbles(:,2), scribbles(:,1) );
end


function mask = bgMask ( visible_scribbles, mask_size )
% Generate a logical mask with true for background scribbles points.
	[ bg_scribbles, ~ ] = Resources.Scribbles.split( visible_scribbles );
	scribbles = round( bg_scribbles );
	mask = Utils.sub2mask( mask_size, scribbles(:,2), scribbles(:,1) );
end


function mask = fgMaskSP ( visible_scribbles, superpixels )
% Generate a logical mask with true for foreground scribbles points.
% Extend with superpixels.
	[ ~, fg_scribbles ] = Resources.Scribbles.split( visible_scribbles );
	scribbles = round( fg_scribbles );
	[ sp_ids, ~ ] = SP.fromSub( superpixels, scribbles(:,2), scribbles(:,1) );
	mask = SP.toMask( superpixels, sp_ids );
end


function mask = bgMaskSP ( visible_scribbles, superpixels )
% Generate a logical mask with true for background scribbles points.
% Extend with superpixels.
	[ bg_scribbles, ~ ] = Resources.Scribbles.split( visible_scribbles );
	scribbles = round( bg_scribbles );
	[ sp_ids, ~ ] = SP.fromSub( superpixels, scribbles(:,2), scribbles(:,1) );
	mask = SP.toMask( superpixels, sp_ids );
end


end % methods


end
