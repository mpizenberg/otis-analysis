function mask = constrainedMask ( superpixels, sp_ids, constraining_mask )
% Get the mask corresponding to the given superpixels ids.
% But all superpixels leaking outside of the constraining mask are removed.
%
% Syntax #####################
%
% mask = SP.constrainedMask( superpixels, sp_ids, constraining_mask );
%
% Description ################
%
% superpixels: Int tensor. Superpixels labels.
% sp_ids: Int vector. The ids of superpixels to extract.
% constraining_mask: logical array. Binary mask defining the authorized area.
% mask: logical tensor. The size of superpixels.


[ sp_bg, ~ ] = SP.fromMask( superpixels, ~constraining_mask );
sp_conflicts = intersect( sp_ids, sp_bg );
sp_noconflicts = setdiff( sp_ids, sp_conflicts );
mask = SP.toMask( superpixels, sp_noconflicts );


end
