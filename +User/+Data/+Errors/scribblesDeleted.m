function nb_delete = scribblesDeleted ( annotations )
% Retrieve the number of "delete last" operations
% for scribbles of one image.
%
% Syntax #####################
%
% nb_delete = User.Data.Errors.scribblesDelete( annotations )
%
% Description ################
%
% annotations: { visible: array cell, deleted: array cell }.
%     For example, user.data.scribbles{1}.annotations .
% nb_delete: int.

nb_delete = length( annotations.deleted );

end
