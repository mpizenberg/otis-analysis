function next_timings = nexts ( user_log )
% Retrieve the timings of the "next" events and reorder them.
%
% Syntax #####################
%
% next_timings = nexts( user_log );
%
% Description ################
%
% user_log: { study: { next: array double, ... }, ... }.
%     For example user.log .
% next_timings: 1 x nb_nexts double array.


next_timings = flip( user_log.study.next );


end
