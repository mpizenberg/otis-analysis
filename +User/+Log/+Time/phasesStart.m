function phases_start = phasesStart ( next_timings )
% Retrieve the timings of the start of the three phases.
% Those are the timings of the end of training image.


% Get the indexes of the start of each phase.
start_indexes = round( 1 + length( next_timings ) * [ 0, 1/3, 2/3 ] );


% Retrieve those timings.
phases_start = next_timings( start_indexes );


end
