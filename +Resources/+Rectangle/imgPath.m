function file_path = imgPath ( resources_path, category_id )
% Retrieve the file path of the raw image based on its id
% and the root resources directory
%
% Syntax #####################
%
% img_path = Resources.Rectangle.imgPath( '/home/me/resources', 6 );
% -> '/home/me/resources/img/gymnast/01.jpg'


% Get file path
file_path = fullfile ...
	( resources_path ...
	, 'img' ...
	, Resources.categoryName( category_id ) ...
	, '01.jpg' ...
	);


end
