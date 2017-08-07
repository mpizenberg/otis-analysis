function durations = allScribbles ( log_scribbles )
% Retrieve the durations of all scribbles.
%
% Syntax #####################
%
% durations = User.Log.Time.allScribbles( log_scribbles );
%
% Description ################
%
% log_scribbles: 1 x nb_images cell array. Contains scribbles mouse events.
%     For example, user.log.study.scribbles
% durations: 1 x nb_images double array.


% Anonymous function to retrieve duration of one image scribbles.
duration = @(scribbles) User.Log.Time.interaction( scribbles{2}.mouse );


% Actual durations
durations = cellfun( duration, log_scribbles );


end
