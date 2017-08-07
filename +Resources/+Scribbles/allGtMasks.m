function gts = allGtMasks ( resources_path, categories )
% Load all Scribbles ground truth masks.
%
% Syntax #####################
%
% gts = Resources.Scribbles.allGtMasks( resources_path, categories );
%
% Description ################
%
% resources_path: String. The path of the resources directory.
% categories: 1 x nb_categories cell array of Strings.
% gts: 1 x nb_categories cell array. Each containing a ground truth mask.


% Anonymous function to load one ground truth mask.
gt_read = @(id) imread( Resources.Scribbles.gtPath( resources_path, categories, id ) );


% Actual ground truths loaded.
nb_categories = length( categories );
gts = arrayfun( gt_read, 1:nb_categories, 'UniformOutput', false );


end
