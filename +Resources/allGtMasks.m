function gts = allGtMasks ( resources_path )
% Load all ground truth masks.
%
% Syntax #####################
%
% gts = Resources.allGtMasks( resources_path );
%
% Description ################
%
% resources_path: String. The path of the resources directory.
% gts: struct { rectangle, outline, scribbles }.
%     each is a 1 x 11 cell array containing GT masks.


gts = struct;
gts.rectangle = Resources.Rectangle.allGtMasks( resources_path );
gts.outline = Resources.Outline.allGtMasks( resources_path );
gts.scribbles = Resources.Scribbles.allGtMasks( resources_path );


end
