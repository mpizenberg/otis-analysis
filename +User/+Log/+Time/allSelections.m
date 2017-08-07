function durations = allSelections ( log_selection )
% Retrieve the durations of all selections (rectangle or outline).
%
% Syntax #####################
%
% durations = User.Log.Time.allSelections( log_selection );
%
% Description ################
%
% log_selection: 1 x nb_images cell array. Contains selections mouse events.
%     For example, user.log.study.rectangle
% durations: 1 x nb_images double array.


% Anonymous function to retrieve duration of one image interaction.
duration = @(sel) User.Log.Time.interaction( sel{2} );


% Actual durations
durations = cellfun( duration, log_selection );


end
