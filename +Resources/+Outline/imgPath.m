function file_path = imgPath ( resources_path, category_id )
% Retrieve the file path of the image based on its id
% and the root resources directory
%
% Syntax #####################
%
% img_path = Resources.Outline.imgPath( '/home/me/resources', 6 );
% -> '/home/me/resources/img/gymnast/02.jpg'


% Get file path
file_path = fullfile ...
	( resources_path ...
	, 'img' ...
	, Resources.categoryName( category_id ) ...
	, '02.jpg' ...
	);


end
