function new_cell_array = mycellfun ( f, cell_array )
% When annoyed by having to add 'UniformOutput', false each time.


new_cell_array = cellfun( f, cell_array, 'UniformOutput', false );


end
