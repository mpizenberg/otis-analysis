function [ files_names, files_paths ] = getFiles( files_folder, ext )
% Get the name and paths of files.

% Separator on the platform used.
sep = filesep;

% Folder containing the files.
folder_info = dir( [ files_folder sep '*.' ext ] );
file_full_names = { folder_info.name };

% Get the files names.
remove_ext_function = @(name) name( 1 : end - ( 1+length(ext) ) );
files_names = cellfun( remove_ext_function, file_full_names, 'UniformOutput', false );

% Get the files full paths.
files_paths = cellfun( @(name) [ files_folder sep name ], file_full_names, 'UniformOutput', false );

end
