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


function [ precisions, recalls, jaccards, masks ] = bg ( user, groundtruths )
	inv_gts = Utils.mycellfun( @(gt) ~gt, groundtruths );
	visible_scribbles = User.Eval.Scribbles.orderedVisibleScribbles( user );
	gt_sizes = Utils.mycellfun( @size, groundtruths );
	[ precisions, recalls, jaccards, masks ] = User.Eval.method ...
		( inv_gts, @Scribbles.bgMask, visible_scribbles, gt_sizes );
end


function [ precisions, recalls, jaccards, masks ] = fg ( user, groundtruths )
	visible_scribbles = User.Eval.Scribbles.orderedVisibleScribbles( user );
	gt_sizes = Utils.mycellfun( @size, groundtruths );
	[ precisions, recalls, jaccards, masks ] = User.Eval.method ...
		( groundtruths, @Scribbles.fgMask, visible_scribbles, gt_sizes );
end


function [ precisions, recalls, jaccards, masks ] = bgSP ( user, groundtruths, superpixels )
	inv_gts = Utils.mycellfun( @(gt) ~gt, groundtruths );
	visible_scribbles = User.Eval.Scribbles.orderedVisibleScribbles( user );
	[ precisions, recalls, jaccards, masks ] = User.Eval.method ...
		( inv_gts, @Scribbles.bgMaskSP, visible_scribbles, superpixels );
end


function [ precisions, recalls, jaccards, masks ] = fgSP ( user, groundtruths, superpixels )
	visible_scribbles = User.Eval.Scribbles.orderedVisibleScribbles( user );
	[ precisions, recalls, jaccards, masks ] = User.Eval.method ...
		( groundtruths, @Scribbles.fgMaskSP, visible_scribbles, superpixels );
end


function [ precisions, recalls, jaccards, masks ] = grabcut ( user, images, groundtruths, superpixels, method )
	visible_scribbles = User.Eval.Scribbles.orderedVisibleScribbles( user );
	methods = repmat( { method }, 1, length( images ) );
	[ precisions, recalls, jaccards, masks ] = User.Eval.method ...
		( groundtruths, @Scribbles.grabcut, images, visible_scribbles,  superpixels, methods );
end


end % methods


end
