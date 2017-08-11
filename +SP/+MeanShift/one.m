function [ superpixels, nb_sp, means, hists ] = one ( img, params )
% Compute mean shift superpixels of an image.
%
% Syntax #####################
%
% SP.MeanShift.one( img, params )
%
% Description ################
%
% img: m x n x 3 RGB matrix. The image to segment.
% params.nbins: Int. The number of bins histograms in each RGB dimension.
% params.hs: Int. The spatial bandwidth (mean-shift).
% params.hr: Int. The range bandwidth (mean-shift).
% params.M: Int. The output regions minmum size (mean-shift).
%
% superpixels: m x n Int array. Superpixels labels.
% nb_sp: Int. The number of superpixels.
% means: 3 x nb_sp array. Each column is the mean color of one superpixel.
% hists: (3*nbins) x nb_sp array. Each column is a superpixel histogram.


% Call the mean shift algorithm through the EDISON wrapper.
[ ~, superpixels, ~, ~, ~, ~ ] = edison_wrapper ...
	( img, @RGB2Luv ...
	, 'SpatialBandWidth', params.hs, 'RangeBandWidth', params.hr ...
	, 'MinimumRegionArea', params.M, 'speedup', 3 ...
	);
superpixels = superpixels + 1; % start at 1 instead of 0.


% Compute mean color and histograms of each superpixel.
[ means, hists ] = SP.appearance( img, superpixels, params.nbins );
nb_sp = size( means, 2 );


end
