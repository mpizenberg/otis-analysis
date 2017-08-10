function varargout = cached ( cache_filepath, f, varargin )
% Transform a function into a cached function (result stored in a file).
% Warning: this obviously is a side effect.

if exist( cache_filepath, 'file' ) == 2
	load( cache_filepath, 'varargout' );
else
	[ varargout{ 1:nargout } ] = f( varargin{:} );
	Utils.mkParentDir( cache_filepath );
	save( cache_filepath, 'varargout' );
end


end
