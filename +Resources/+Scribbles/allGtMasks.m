function gts = allGtMasks ( resources_path )
% Load all Scribbles ground truth masks.
%
% Syntax #####################
%
% gts = Resources.Scribbles.allGtMasks( resources_path );
%
% Description ################
%
% resources_path: String. The path of the resources directory.
% gts: 1 x 11 cell array. Each containing a ground truth mask.


% Anonymous function to load one ground truth mask.
gt_read = @(id) Resources.Scribbles.gtMask( resources_path, id );


% Actual ground truths loaded.
gts = arrayfun( gt_read, 1:11, 'UniformOutput', false );


end
