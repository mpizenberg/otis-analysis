function mask = toMask ( superpixels, sp_ids )
% Get the mask corresponding to the given superpixels ids.
%
% Syntax #####################
%
% mask = SP.toMask( superpixels, sp_ids );
%
% Description ################
%
% superpixels: Int tensor. Superpixels labels.
% sp_ids: Int vector. The ids of superpixels to extract.
% mask: logical tensor. The size of superpixels.


mask = ismember( superpixels, sp_ids );


end
