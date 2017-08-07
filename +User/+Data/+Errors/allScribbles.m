function errors = allScribbles ( data_scribbles )
% Retrieve the number of deleted scribbles for all images.
%
% Syntax #####################
%
% errors = User.Data.Errors.allScribbles( data_scribbles );
%
% Description ################
%
% data_scribbles: 1 x nb_images cell array.
%     Each cell is a struct with at least an 'annotations' field.
%     For example, it can be user.data.scribbles .
% errors: 1 x nb_images array of int.


% Anonymous function to retrieve the number of delete of one image.
nbDeleted = @(scribbles) User.Data.Errors.scribblesDeleted( scribbles.annotations );


% Actual number of scribbles deletions.
errors = cellfun( nbDeleted, data_scribbles );


end
