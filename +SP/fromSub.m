function [ sp_ids, hist_ids ] = fromSub ( superpixels, row_sub, col_sub )
% Get the superpixels ids corresponding to the subscripts given.
% Also return the repartition histogram of the subscripts in those superpixels.
% e.g. If the extracted points are from the following superpixels:
% [ 3 4 1 4 1 6 6 6 6 6 ], (10 points) we will obtain:
% sp_ids   = [1 3 4 6]
% hist_ids = [2 1 2 5] (sum equals 10)
%
% Syntax #####################
%
% [ sp_ids, hist_ids ] = SP.fromSub( superpixels, row_sub, col_sub );
%
% Description ################
%
% superpixels: Int array. Superpixels labels.
% row_sub: sub vector. Row subscripts of points to extract.
% col_sub: sub vector. Column subscripts of points to extract.
% sp_ids: Int vector. The ids of superpixels extracted.
% hist_ids: Int vector. Occurence of each sp in sp_ids.


% Filter to keep only the points inside the matrix
matrix_size = size( superpixels );
n_row = matrix_size(1);
n_col = matrix_size(2);
idx_ok = row_sub >= 1 & row_sub <= n_row & col_sub >= 1 & col_sub <= n_col;


% Get the corresponding superpixels ids
ids = superpixels( sub2ind( matrix_size, row_sub(idx_ok), col_sub(idx_ok) ) );
sp_ids = sort( unique( ids ) );
hist_ids = histcounts( ids, [ sp_ids(:); sp_ids(end) + 1 ] );


end
