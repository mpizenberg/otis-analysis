classdef (Abstract) Plots


methods (Static, Access=private)


function fig_handle = box ( all_quantiles, labels, x_label, x_axis, fig_size )
	% Transform quantiles [0, 0.25, 0.5, 0.75, 1] to a vector usable by "boxplot".
	% The trick to be able to use boxplot is to add the median once.
	plotable_quantiles = cellfun ...
		( @(quantiles) [ quantiles(:); quantiles(3) ] ...
		, all_quantiles ...
		, 'UniformOutput', false ...
		);
	fig_handle = figure;
	set( fig_handle, 'Visible', 'off' );
	boxplot ...
		( cell2mat( plotable_quantiles ) ...
		, labels ...
		, 'Orientation', 'horizontal' ...
		, 'PlotStyle', 'compact' ...
		, 'Whisker', inf ...
		);
	nb_lines = length( labels );
	y_axis = [ 0, nb_lines + 1 ];
	axis( [ x_axis, y_axis ] );
	xlabel( x_label, 'FontSize', 12 );
	set( gcf, 'units', 'points', 'position', [0, 0, fig_size] );
	pbaspect( [20, nb_lines + 1, 1] );
end


function savePdf ( fig_handle, file_path )
	pos = get( fig_handle, 'Position' );
	set( fig_handle ...
		, 'PaperPositionMode', 'Auto' ...
		, 'PaperUnits', 'points' ...
		, 'PaperSize', pos(3:4) ...
		);
	print( fig_handle, file_path, '-dpdf', '-r0' );
end


end % private methods


methods (Static)


function duration ( users, file_path )
% Plot Figure 10.
% users must be an horizontal cell array. { user1, ..., usern }.
	durations_rectangle = Utils.mycellfun ...
		( @(user) User.Log.Time.allSelections( user.log.study.rectangle ) ...
		, users ...
		);
	durations_outline = Utils.mycellfun ...
		( @(user) User.Log.Time.allSelections( user.log.study.outline ) ...
		, users ...
		);
	durations_scribbles = Utils.mycellfun ...
		( @(user) User.Log.Time.allScribbles( user.log.study.scribbles ) ...
		, users ...
		);
	quantiles = Utils.mycellfun ...
		( @(durations) quantile( cell2mat( durations ), linspace( 0, 1, 5 ) ) ...
		, { durations_rectangle, durations_outline, durations_scribbles } ...
		);
	labels = { 'Bounding box', 'Outline', 'Scribbles' };
	x_label = 'Duration of interaction type in seconds (lower is better)';
	x_axis = [ 0, 20 ];
	fig_size = [ 600, 200 ];
	fig_handle = Paper.Plots.box( quantiles, labels, x_label, x_axis, fig_size );
	Paper.Plots.savePdf( fig_handle, file_path );
end


function errors ( users, file_path )
% Plot Figure 11.
	errors_rectangle = Utils.mycellfun ...
		( @(user) User.Data.Errors.allSelections( user.data.rectangle ) ...
		, users ...
		);
	errors_outline = Utils.mycellfun ...
		( @(user) User.Data.Errors.allSelections( user.data.outline ) ...
		, users ...
		);
	errors_scribbles = Utils.mycellfun ...
		( @(user) User.Data.Errors.allScribbles( user.data.scribbles ) ...
		, users ...
		);
	quantiles = Utils.mycellfun ...
		( @(errors) quantile( cell2mat( errors ), linspace( 0, 1, 5 ) ) ...
		, { errors_rectangle, errors_outline, errors_scribbles } ...
		);
	labels = { 'Bounding box', 'Outline', 'Scribbles' };
	x_label = 'Number of wrong attempts for all 11 images (lower is better)';
	x_axis = [ 0, 15 ];
	fig_size = [ 600, 200 ];
	fig_handle = Paper.Plots.box( quantiles, labels, x_label, x_axis, fig_size );
	Paper.Plots.savePdf( fig_handle, file_path );
end


function precisionBG ( users, file_path )
% Plot Figure 12.
	precision_rectangle = ...
	precision_outline = ...
	precision_scribbles = ...
	quantiles = ...
	labels = { 'Scribbles with superpixels', 'Bounding box', 'Outline' };
	x_label = 'Precision of background user input';
	x_axis = [ 0.6, 1 ];
	fig_size = [ 600, 200 ];
	fig_handle = Paper.Plots.box( quantiles, labels, x_label, x_axis, fig_size );
	Paper.Plots.savePdf( fig_handle, file_path );
end


end % methods


end