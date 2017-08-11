function [ all_sp, all_nb_sp, all_means, all_hists ] = all ( img_paths, sp_dir )
% Oversegment all images.
%
% Syntax #####################
%
% [ all_sp, all_nb_sp, all_means, all_hists ] = SP.MeanShift.all( img_paths, sp_dir );
%
% Description ################
%
% img_paths: nb_img x 1 cell array. The paths for all the images.
% sp_dir: string. The folder where superpixels results will be saved.
%
% all_sp: nb_img x 1 cell array. Matrices with same sizes than the images.
%     The segments labels for every pixel.
% all_nb_sp: nb_img x 1 vector. The number of superpixels for each image.
% means: nb_img x 1 cell array. For each image, 3 x nb_sp array.
%     Mean color of each superpixel.
% hists: nb_img x 1 cell array. For each image, (3*nbins) x nb_sp array.
%     The histograms of each superpixels.


% Mean-shift parameters
params.hs = 10; % spatial bandwidth
params.hr = 7; % range bandwidth
params.M = 30; % output regions minimum size
params.nbins = 20; % 20 bins histograms in each RGB dimension


% Initialization
nb_img = length( img_paths );
all_sp = cell( nb_img, 1 );
all_nb_sp = zeros( nb_img, 1 );
all_means = cell( nb_img, 1 );
all_hists = cell( nb_img, 1 );
upd = Utils.textProgressBar( nb_img, 'updatestep', 1 ); % progress bar


% Compute superpixels of each image.
for i = 1 : nb_img
	[ parent_dir, img_name, ~ ] = fileparts( img_paths{i} );
	[ ~, category_name, ~ ] = fileparts( parent_dir );
	cache_file = fullfile( sp_dir, category_name, [ img_name '.mat' ] );
	img = imread( img_paths{i} );
	[ all_sp{i}, all_nb_sp(i), all_means{i}, all_hists{i} ] = ...
		Utils.cached( cache_file, @SP.MeanShift.one, img, params );

	upd(i); % update progress
end


end
