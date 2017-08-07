function init_time = init ( user_log )
% Get the time at which the page Study is loaded for the first time.
%
% Syntax #####################
%
% init_time = User.Log.Time.init( user_log );
%
% Description ################
%
% user_log: { navigation: cell array, ... }. For example user.log .
% init_time: double.


% Initialization
init_time = 0;


% The events are stored in reverse order
% so we keep the time of the last navigation event named 'study'
for nav = user_log.navigation{:}
	if strcmp( nav.event, 'study' )
		init_time = nav.time;
	end
end


end
