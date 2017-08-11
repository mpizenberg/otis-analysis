function [ means, hists ] = appearance ( img, superpixels, nb_bins )
% Compute the mean color and the color histogram of each superpixel.
%
% Syntax #####################
%
% [ means, hists ] = SP.appearance( img, superpixels, nb_bins );
%
% Description ################
%
% img: m x n x d uint8 array. RGB or gray image.
% superpixels: m x n Int array. Superpixels labels.
% nb_bins: int. The number of bins of each histograms.
% means: d x nb_sp array. Each column is the mean color of one superpixel.
% hists: (d*nb_bins) x nb_sp array. Each column is a superpixel histogram.


% Compute the histograms edges [ 0, 256/nb_bins, ... , 256 ]
assert( nb_bins > 0, 'The number of histograms bins must be a positive integer' );
edges = round( (0:nb_bins) * (256/nb_bins) );


% Small function to retrieve the correct histogram rows for a canal.
% histRows(1) = 1 : nb_bins
% histRows(2) = nb_bins+1 : 2*nb_bins
histRows = @(canal) ( (canal-1)*nb_bins + 1 ) : canal*nb_bins;


% Retrieve the number of superpixels.
[ unique_sp, ~, ~ ] = unique( superpixels );
nb_sp = length( unique_sp );
assert ...
	( unique_sp(1) == 1 && unique_sp(end) == nb_sp ...
	, 'There is something wrong with the superpixels' ...
	);


% Retrieve the size of the image. d = 3 for a RGB color image.
% Resize the image, one column per canal.
[ ~, ~, d ] = size( img );
flat_img = reshape( img, [], d );


% Initialize means and hists.
means = zeros( d, nb_sp );
hists = zeros( d*nb_bins, nb_sp );


% Compute mean and histogram for each superpixel.
for sp_id = 1:nb_sp
	current_sp = flat_img( superpixels == sp_id, : );
	means( :, sp_id ) = mean( current_sp, 1 );
	for canal = 1:d
		hists( histRows(canal), sp_id ) = histcounts( current_sp( :, canal ), edges );
	end
end


end
