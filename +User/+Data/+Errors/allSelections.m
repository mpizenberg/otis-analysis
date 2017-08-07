function errors = allSelections ( data_selection )
% Retrieve the number of "redo" of selections for all images.
%
% Syntax #####################
%
% errors = User.Data.Errors.allSelections( data_selection );
%
% Description ################
%
% data_selection: 1 x nb_images cell array.
%     selections are rectangle or outline annotations.
%     Each cell is a struct with at least an 'annotations' field.
%     For example, it can be user.data.rectangle .
% errors: 1 x nb_images array of int.


% Anonymous function to retrieve the number of "redo" in one image.
nb_redo = @(sel) User.Data.Errors.selectionRedo( sel.annotations );


% Actual number of redo.
errors = cellfun( nb_redo, data_selection );


end
