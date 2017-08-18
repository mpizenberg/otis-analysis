classdef (Abstract) Scribbles


methods (Static, Access=private)


function annotations = orderedVisibleScribbles ( user )
	[ ~, img_order ] = sort( User.Data.Order.images( user.data.scribbles ) );
	nb_img = length( img_order );
	annotations = cell( 1, nb_img );
	for i = 1:nb_img
		annotations{i} = user.data.scribbles{ img_order(i) }.annotations.visible;
	end
end


end % private methods


methods (Static)


function [ precisions, recalls, jaccards ] = bg ( user, groundtruths )
	inv_gts = Utils.mycellfun( @(gt) ~gt, groundtruths );
	visible_scribbles = User.Eval.Scribbles.orderedVisibleScribbles( user );
	gt_sizes = Utils.mycellfun( @size, groundtruths );
	[ precisions, recalls, jaccards ] = User.Eval.method ...
		( inv_gts, @Scribbles.bgMask, visible_scribbles, gt_sizes );
end


function [ precisions, recalls, jaccards ] = fg ( user, groundtruths )
	visible_scribbles = User.Eval.Scribbles.orderedVisibleScribbles( user );
	gt_sizes = Utils.mycellfun( @size, groundtruths );
	[ precisions, recalls, jaccards ] = User.Eval.method ...
		( groundtruths, @Scribbles.fgMask, visible_scribbles, gt_sizes );
end


function [ precisions, recalls, jaccards ] = bgSP ( user, groundtruths, superpixels )
	inv_gts = Utils.mycellfun( @(gt) ~gt, groundtruths );
	visible_scribbles = User.Eval.Scribbles.orderedVisibleScribbles( user );
	[ precisions, recalls, jaccards ] = User.Eval.method ...
		( inv_gts, @Scribbles.bgMaskSP, visible_scribbles, superpixels );
end


function [ precisions, recalls, jaccards ] = fgSP ( user, groundtruths, superpixels )
	visible_scribbles = User.Eval.Scribbles.orderedVisibleScribbles( user );
	[ precisions, recalls, jaccards ] = User.Eval.method ...
		( groundtruths, @Scribbles.fgMaskSP, visible_scribbles, superpixels );
end


end % methods


end
