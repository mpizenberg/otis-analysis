function imgs = allImgs ( resources_path, categories )
% Load all images.

idToImg = @(id) imread( Resources.Rectangle.imgPath( resources_path, categories, id ) );
imgs = arrayfun( idToImg, 1:length(categories), 'UniformOutput', false );

end
