function file_path = gtPath ( resources_path, category_id )
% Retrieve the file path of the ground truth mask based on its id
% and the root resources directory.
%
% Syntax #####################
%
% gt_path = Resources.Rectangle.gtPath( '/home/me/resources', 6 );
% -> '/home/me/resources/groundtruth/gymnast/01.png'


% Get file path
file_path = fullfile ...
	( resources_path ...
	, 'groundtruth' ...
	, Resources.categoryName( category_id ) ...
	, '01.png' ...
	);


end
