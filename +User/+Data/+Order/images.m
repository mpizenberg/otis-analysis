function order = images ( data_interaction )
% Retrieve the images names in their order of appearance.
%
% Syntax #####################
%
% order = User.Data.Order.images( data_interaction );
%
% Description ################
%
% data_interaction: 1 x nb_images cell array.
%     Each cell is a struct with at least an 'image' field.
%     For example, it can be user.data.rectangle .
% order: 1 x nb_images cell array of String.


% Anonymous function to get the image name.
imageName = @(image) image.image;


% The actual list of images names.
order = cellfun( imageName, data_interaction, 'UniformOutput', false );


end
