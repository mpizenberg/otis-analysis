function duration = interaction ( mouse_events )
% Mesure the duration of an interaction (for one image).
% Here, errors are taken into account since they are intrinsically
% tied to the way the interaction works.
%
% Syntax #####################
%
% duration = User.Log.Time.interaction( mouse_events );
%
% Description ################
%
% mouse_events: 1 x nb_events cell array.
%     Each cell contains a struct of the form:
%     { time: double, event: String }
%     For example, user.log.study.scribbles{6}{2}.mouse
%     or user.log.study.rectangle{6}{2}   (no mouse)
% duration: double


% Mouse events were logged in the reverse order (LIFO).
last_up = mouse_events{1}.time;
first_down = mouse_events{end}.time;
duration = last_up - first_down;


end
