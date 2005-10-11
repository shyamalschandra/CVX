function ans = ge( x, y )
error( nargchk( 2, 2, nargin ) );

%
% Check problem
%

cvx_problem = evalin( 'caller', 'cvx_problem', '[]' );
if ~isa( cvx_problem, 'cvxprob' ),
    error( 'The ''>='' operator is not defined for structs outside of cvx.' );
end

%
% Check curvature
%

if ~cvx_isconcave( x ),
    error( sprintf( 'Disciplined convex programming error:\n    The left-hand side of a ">=" inequality must be concave.' ) );
elseif ~cvx_isconvex( y ),
    error( sprintf( 'Disciplined convex programming error:\n    The right-hand side of a ">=" inequality must be convex.' ) );
end

%
% Process constraint
%

newcnstr( cvx_problem, x, y, '>=' );

% Copyright 2005 Michael C. Grant and Stephen P. Boyd. 
% See the file COPYING.txt for full copyright information.
% The command 'cvx_where' will show where this file is located.
