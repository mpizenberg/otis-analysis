function phases_duration = phasesDuration ( next_timings )
% Retrieve the duration of each phase (without training).


phases_start = User.Log.Time.phasesStart( next_timings );
phases_end = User.Log.Time.phasesEnd( next_timings );
phases_duration = phases_end - phases_start;

end
