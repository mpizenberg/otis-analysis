function name = categoryName ( category_id )
% Retrieve the name of the image category (balloon, ...) with its id.
%
% Syntax #####################
%
% name = Resources.categoryName( 1 );
% -> 'balloon'


% The categories
categories = ...
	{ 'balloon' ...
	, 'baseball' ...
	, 'bear' ...
	, 'cheetah' ...
	, 'ferrari' ...
	, 'gymnast' ...
	, 'helicopter' ...
	, 'kite' ...
	, 'pyramid' ...
	, 'statue_of_liberty' ...
	, 'taj_mahal' ...
	};


% The name
name = categories{ category_id };


end
