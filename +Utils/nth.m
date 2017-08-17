function varargout = nth ( n, varargin )
	nb_arguments = length(varargin);
	for i = 1:nb_arguments
		varargout{i} = varargin{i}{n};
	end
end
