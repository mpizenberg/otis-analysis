function file_path = imgPath ( resources_path, categories, id )
% Retrieve the file path of the raw image based on its id
% and the root resources directory
%
% Syntax #####################
%
% img_path = Resources.Scribbles.imgPath( '/home/me/resources', categories, 6 );
% -> '/home/me/resources/img/gymnast/03.jpg'


% Get file path
file_path = fullfile ...
	( resources_path ...
	, 'img' ...
	, categories{ id } ...
	, '03.jpg' ...
	);


end
