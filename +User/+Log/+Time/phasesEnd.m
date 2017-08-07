function phases_end = phasesEnd ( next_timings )
% Retrieve the timings of the end of the three phases.


% Then get the indexes of the end of each phase.
end_indexes = round( length( next_timings ) * [ 1/3, 2/3, 3/3 ] );


% Retrieve those timings.
phases_end = next_timings( end_indexes );


end
