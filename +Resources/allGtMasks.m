function gts = allGtMasks ( resources_path, categories )
% Load all ground truth masks.
%
% Syntax #####################
%
% gts = Resources.allGtMasks( resources_path, categories );
%
% Description ################
%
% resources_path: String. The path of the resources directory.
% categories: 1 x nb_categories cell array of Strings.
% gts: struct { rectangle, outline, scribbles }.
%     each is a 1 x nb_categories cell array containing GT masks.


gts = struct;
gts.rectangle = Resources.Rectangle.allGtMasks( resources_path, categories );
gts.outline = Resources.Outline.allGtMasks( resources_path, categories );
gts.scribbles = Resources.Scribbles.allGtMasks( resources_path, categories );


end
