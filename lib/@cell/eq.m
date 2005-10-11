function ans = eq( x, y )
error( nargchk( 2, 2, nargin ) );

%
% Check problem
%

cvx_problem = evalin( 'caller', 'cvx_problem', '[]' );
if ~isa( cvx_problem, 'cvxprob' ),
    error( 'The ''=='' operator is not defined for cell arrays outside of cvx.' );
end

%
% Check curvature
%

if ~cvx_isaffine( x ) | ~cvx_isaffine( y ),
    error( sprintf( 'Disciplined convex programming error:\n    Both sides of an equality constraint must be affine.' ) );
end

%
% Perform computations
%

newcnstr( cvx_problem, x, y, '=' );
if nargout > 0, ans = {}; end
    
% Copyright 2005 Michael C. Grant and Stephen P. Boyd. 
% See the file COPYING.txt for full copyright information.
% The command 'cvx_where' will show where this file is located.
