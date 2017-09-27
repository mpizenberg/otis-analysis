classdef (Abstract) Superpixels


methods (Static)


function [ mask ] = boundaries ( superpixels )
	gx = logical( superpixels - superpixels( :, [2:end, end] ) );
	gy = logical( superpixels - superpixels( [2:end, end], : ) );
	mask = gx | gy;
end


function [ visualization ] = colors ( superpixels, colormap )
	% Use (superpixels - 1) since colormap start for the value 0
	% and superpixels indexes start at 1.
	visualization = ind2rgb( superpixels - 1, colormap );
end


function [ visualization ] = parula ( superpixels )
	nb_sp = max( superpixels(:) );
	visualization = View.Superpixels.colors( superpixels, parula( nb_sp ) );
end


function [ visualization ] = means ( superpixels, img )
	[ sp_means, ~ ] = SP.appearance( img, superpixels, 1 );
	visualization = uint8( View.Superpixels.colors( superpixels, sp_means' ) );
end


end % methods


end
