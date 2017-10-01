classdef (Abstract) Rectangle


methods (Static)


function annotations = orderedRectangles ( user )
	[ ~, img_order ] = sort( User.Data.Order.images( user.data.rectangle ) );
	nb_img = length( img_order );
	annotations = cell( 1, nb_img );
	for i = 1:nb_img
		annotations{i} = user.data.rectangle{ img_order(i) }.annotations{1};
	end
end


function [ precisions, recalls, jaccards, masks ] = bg ( user, groundtruths )
	gts = Utils.mycellfun( @(gt) ~gt, groundtruths );
	rectangles = User.Eval.Rectangle.orderedRectangles( user );
	gt_sizes = Utils.mycellfun( @size, groundtruths );
	[ precisions, recalls, jaccards, masks ] = User.Eval.method ...
		( gts, @Rectangle.bgMask, rectangles, gt_sizes );
end


function [ precisions, recalls, jaccards, masks ] = fg ( user, groundtruths )
	rectangles = User.Eval.Rectangle.orderedRectangles( user );
	gt_sizes = Utils.mycellfun( @size, groundtruths );
	[ precisions, recalls, jaccards, masks ] = User.Eval.method ...
		( groundtruths, @Rectangle.fgMask, rectangles, gt_sizes );
end


function [ precisions, recalls, jaccards, masks ] = grabcut ( user, images, groundtruths, all_sp )
	rectangles = User.Eval.Rectangle.orderedRectangles( user );
	[ precisions, recalls, jaccards, masks ] = User.Eval.method ...
		( groundtruths, @Rectangle.grabcut, images, rectangles,  all_sp );
end

end % methods


end
