function [ sp_ids, hist_ids ] = fromMask ( superpixels, mask )
% Get the superpixels ids corresponding to mask given.
% Also return the repartition histogram of the points in those superpixels.
% e.g. If the extracted points are from the following superpixels:
% [ 3 4 1 4 1 6 6 6 6 6 ], (10 points) we will obtain:
% sp_ids   = [1 3 4 6]
% hist_ids = [2 1 2 5] (sum equals 10)
%
% Syntax #####################
%
% [ sp_ids, hist_ids ] = SP.fromMask( superpixels, mask );
%
% Description ################
%
% superpixels: m x n Int array. Superpixels labels.
% mask: m x n logical array. The mask to extract.
% sp_ids: Int vector. The ids of superpixels extracted.
% hist_ids: Int vector. Occurence of each sp in sp_ids.


% Careful if the mask is empty
if any( mask(:) )
	% Get the corresponding SP ids
	ids = transpose( superpixels( mask ) );
	sp_ids = sort( unique( ids ) );
	hist_ids = histcounts( ids, [ sp_ids(:); sp_ids(end) + 1 ] );
else
	sp_ids = [];
	hist_ids = [];
end


end
