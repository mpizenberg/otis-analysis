function tool_index = toolIndex ( tool_order )
% Retrieve the order index (1, 2 or 3) of each tool/interaction.
%
% Syntax #####################
%
% tool_index = User.Data.Order.toolIndex( tool_order );
%
% Description ################
%
% tool_order: 1x3 cell array containing 'rectangle', 'outline' and 'scribbles'
%    in an unknown order.
% tool_index: { rectangle: int, outline: int, scribbles: int }

tool_index = struct;
tool_index.rectangle = find( strcmp( tool_order, 'rectangle' ) );
tool_index.outline = find( strcmp( tool_order, 'outline' ) );
tool_index.scribbles = find( strcmp( tool_order, 'scribbles' ) );

end
