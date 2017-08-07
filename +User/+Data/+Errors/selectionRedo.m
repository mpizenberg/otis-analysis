function nb_redo = selectionRedo ( annotations )
% Retrieve the number of "redo" of a selection.
% If the user manage to do a correct selection the first time,
% this will return 0.
% Otherwise, it returns the number of times the user has re-selected.
%
% Syntax #####################
%
% nb_redo = User.Data.Errors.selectionRedo( annotations )
%
% Description ################
%
% annotations: nb_redo x 1 cell array. Each cell contain one annotation.
%     For example, user.data.rectangle{1}.annotations
% nb_redo: int.

nb_redo = length( annotations ) - 1;

end
