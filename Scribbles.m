classdef (Abstract) Scribbles
% Manipulation of scribbles annotations.
% In all these functions, the first `visible_scribbles` argument
% is cell array containing each visible scribble coming from json annotations.


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
	[ bg_scribbles, fg_scribbles ] = Resources.Scribbles.split( visible_scribbles );
	bg_scrib = round( bg_scribbles );
	fg_scrib = round( fg_scribbles );
	[ bg_sp_ids, ~ ] = SP.fromSub( superpixels, bg_scrib(:,2), bg_scrib(:,1) );
	[ fg_sp_ids, ~ ] = SP.fromSub( superpixels, fg_scrib(:,2), fg_scrib(:,1) );
	sp_ids = setdiff( fg_sp_ids, bg_sp_ids );
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
