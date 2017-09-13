function main ( resources_dir, users_annotations_dir, save_results_dir )
% Generate analysis of users annotations and save the results.



% Load the users annotations.
disp( 'Loading users annotations ...' );
[ ~, json_file_paths ] = Utils.getFiles( users_annotations_dir, 'json' );
users = Utils.mycellfun( @Utils.loadjson, json_file_paths );



% Load ground truths.
disp( 'Loading ground truths masks ...' );
categories = Resources.otisCategories;
all_gts = Resources.allGtMasks( resources_dir, categories );



% Get the images file paths.
disp( 'Deducing images file paths ...' );
img_paths = struct;
imgPaths = @(f) arrayfun( @(id) f( resources_dir, categories, id ), (1:length(categories))', 'UniformOutput', false );
img_paths.rectangle = imgPaths( @Resources.Rectangle.imgPath );
img_paths.outline = imgPaths( @Resources.Outline.imgPath );
img_paths.scribbles = imgPaths( @Resources.Scribbles.imgPath );



% Load / Compute the superpixels.
disp( 'Loading / computing superpixels of each group of images ...' );
sp_dir = fullfile( save_results_dir, 'superpixels' );
all_sp = struct;
all_sp.rectangle = SP.MeanShift.all( img_paths.rectangle, sp_dir );
all_sp.outline = SP.MeanShift.all( img_paths.outline, sp_dir );
all_sp.scribbles = SP.MeanShift.all( img_paths.scribbles, sp_dir );



% Generate the paper figures.
disp( 'Generating paper figures ...' );
paper_dir = fullfile( save_results_dir, 'paper' );
figures_dir = fullfile( paper_dir, 'figures' );
Utils.mkParentDir( fullfile( figures_dir, 'whatever' ) );

gymnast_outline = users{1}.data.outline{1}.annotations{1};
gymnast_sp = all_sp.outline{6};
gymnast_img = imread( img_paths.outline{6} );

fig_4a = Paper.Figures.fgErosion( all_gts.outline{6}, gymnast_outline );
fig_4b = Paper.Figures.fgSkeleton( all_gts.outline{6}, gymnast_outline );
fig_4c = Paper.Figures.fgErosionSP( all_gts.outline{6}, gymnast_outline, gymnast_sp );
fig_4d = Paper.Figures.fgSkeletonSP( all_gts.outline{6}, gymnast_outline, gymnast_sp );

fig_5a = Paper.Figures.bmaDisks( gymnast_outline, gymnast_img );
fig_5b = Paper.Figures.bmaDisksPruned( gymnast_outline, gymnast_img );

Utils.mkParentDir( fullfile( figures_dir, 'whatever' ) );
imwrite( fig_4a, fullfile( figures_dir, '4a.png' ) );
imwrite( fig_4b, fullfile( figures_dir, '4b.png' ) );
imwrite( fig_4c, fullfile( figures_dir, '4c.png' ) );
imwrite( fig_4d, fullfile( figures_dir, '4d.png' ) );
imwrite( fig_5a, fullfile( figures_dir, '5a.jpg' ) );
imwrite( fig_5b, fullfile( figures_dir, '5b.jpg' ) );



% Generate the paper plots.
disp( 'Generating paper plots ...' );
plots_dir = fullfile( paper_dir, 'plots' );
Utils.mkParentDir( fullfile( plots_dir, 'whatever' ) );

fig_10_path = fullfile( plots_dir, '10.pdf' );
fig_11_path = fullfile( plots_dir, '11.pdf' );
fig_12_path = fullfile( plots_dir, '12.pdf' );
fig_13_path = fullfile( plots_dir, '13.pdf' );
fig_14_path = fullfile( plots_dir, '14.pdf' );
fig_15_path = fullfile( plots_dir, '15.pdf' );

upd = Utils.textProgressBar( 6, 'updatestep', 1 ); % progress bar
Paper.Plots.duration( users, fig_10_path ); upd(1);
Paper.Plots.errors( users, fig_11_path ); upd(2);
Paper.Plots.background( users, all_gts, all_sp, fig_12_path, fig_13_path ); upd(4);
Paper.Plots.foreground( users, all_gts, all_sp, fig_14_path, fig_15_path ); upd(6);



% Generate the poster-specific plots.
disp( 'Generating poster plots ...' );
poster_dir = fullfile( paper_dir, 'poster' );
Utils.mkParentDir( fullfile( poster_dir, 'whatever' ) );

poster_duration_path = fullfile( poster_dir, 'duration.pdf' );
poster_errors_path = fullfile( poster_dir, 'errors.pdf' );
poster_bg_path = fullfile( poster_dir, 'bg.pdf' );
poster_fg_path = fullfile( poster_dir, 'fg.pdf' );

upd = Utils.textProgressBar( 4, 'updatestep', 1 ); % progress bar
Paper.Plots.durationPoster( users, poster_duration_path ); upd(1);
Paper.Plots.errorsPoster( users, poster_errors_path ); upd(2);
Paper.Plots.bgPoster( users, all_gts, all_sp, poster_bg_path ); upd(3);
Paper.Plots.fgPoster( users, all_gts, all_sp, poster_fg_path ); upd(4);



save % to inspect all variables a posteriori.



end
