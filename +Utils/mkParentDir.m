function mkParentDir ( file_path )
% Create file parent directory if it does not already exist.


[ parent_dir, ~, ~ ] = fileparts( file_path );

if ~ isempty( parent_dir ) && ~ exist( parent_dir, 'dir' )
	mkdir( parent_dir );
end


end
