classdef (Abstract) Rectangle


methods (Static, Access=private)


function annotations = orderedRectangles ( user )
	[ ~, img_order ] = sort( User.Data.Order.images( user.data.rectangle ) );
	nb_img = length( img_order );
	annotations = cell( 1, nb_img );
	for i = 1:nb_img
		annotations{i} = user.data.rectangle{ img_order(i) }.annotations{1};
	end
end


end % private methods


methods (Static)


function [ precisions, recalls, jaccards ] = bg ( user, groundtruths )
	gts = Utils.mycellfun( @(gt) ~gt, groundtruths );
	rectangles = User.Eval.Rectangle.orderedRectangles( user );
	gt_sizes = Utils.mycellfun( @size, groundtruths );
	[ precisions, recalls, jaccards ] = User.Eval.method ...
		( gts, @Rectangle.bgMask, rectangles, gt_sizes );
end


function [ precisions, recalls, jaccards ] = fg ( user, groundtruths )
	rectangles = User.Eval.Rectangle.orderedRectangles( user );
	gt_sizes = Utils.mycellfun( @size, groundtruths );
	[ precisions, recalls, jaccards ] = User.Eval.method ...
		( groundtruths, @Rectangle.fgMask, rectangles, gt_sizes );
end


function [ precisions, recalls, jaccards ] = grabcut ( images, user, groundtruths, all_sp )
	rectangles = User.Eval.Rectangle.orderedRectangles( user );
	[ precisions, recalls, jaccards ] = User.Eval.method ...
		( groundtruths, @Rectangle.grabcut, images, rectangles,  all_sp );
end

end % methods


end
