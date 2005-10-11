function cvx_optval = square( x )
error( nargchk( 1, 1, nargin ) );

%SQUARE    Square.
%
%   SQUARE(X) is an array of the same size as X, whose elements are the
%   squares of the elements of X.
%
%   Disciplined quadratic programming information:
%       If X is real, then SQUARE(X) is convex and nonmonotonic in X. If X
%       is complex, then SQUARE(X) is neither convex nor concave. Thus when
%       when use in CVX expressions, X must be real and affine.

if ~isreal( x ),
    error( sprintf( 'Disciplined convex programming error:\n   The argument to SQUARE must be real and affine.' ) );
end
cvx_optval = quad_over_lin( x, 1, 0 );

% Copyright 2005 Michael C. Grant and Stephen P. Boyd. 
% See the file COPYING.txt for full copyright information.
% The command 'cvx_where' will show where this file is located.
