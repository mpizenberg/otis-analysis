function [ precisions, recalls, jaccards, masks ] = method ( gts, f, varargin )
	nb_img = length( gts );

	% Initialize return variables.
	precisions = zeros( 1, nb_img );
	recalls = zeros( 1, nb_img );
	jaccards = zeros( 1, nb_img );
	masks = cell( 1, nb_img );

	% Evaluate all outlines.
	for i = 1 : nb_img
		nb_arguments = length( varargin );
		[ arguments{1:nb_arguments} ] = Utils.nth( i, varargin{:} );
		masks{i} = f( arguments{:} );
		[ p, r, j ] = Utils.evalBinaryClassif( masks{i}, gts{i} );
		precisions( i ) = p;
		recalls( i ) = r;
		jaccards( i ) = j;
	end
end
