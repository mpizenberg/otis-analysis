function [ bg_scribbles, fg_scribbles ] = split ( visible_scribbles )
% Retrieve and split all points of BG and FG scribbles from
% user.data.scribbles{#}.annotations.visibles


% Initialization
nb_scribbles = length( visible_scribbles );
bg_scribbles = zeros( 0, 2 );
fg_scribbles = zeros( 0, 2 );


% Retrieve BG and FG scribbles
for i = 1:nb_scribbles
	s = visible_scribbles{i};
	if strcmp( 'BG', s.type )
		bg_scribbles = cat( 1, bg_scribbles, s.path );
	else
		fg_scribbles = cat( 1, fg_scribbles, s.path );
	end
end


end
