function gt_mask = gtMask ( resources_path, category_id )
% Retrieve the ground truth mask based on its id
% and the root resources directory.
%
% Syntax #####################
%
% gt_mask = Resources.Scribbles.gtMask( '/home/me/resources', 6 );


gt_mask = imread( Resources.Scribbles.gtPath( resources_path, category_id ) );

end
