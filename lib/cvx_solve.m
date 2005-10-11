function cvx_solve( presolve )
global cvx___
prob = evalin( 'caller', 'cvx_problem', '[]' );
if isempty( prob ) | ~isa( prob, 'cvxprob' ),
    error( 'No cvx problem exists in this scope.' );
elseif cvx___.stack{ end } ~= prob,
    error( 'Internal cvx data corruption.' );
else,
    if nargin < 1 | presolve, eliminate( prob ); end
    solve( prob, cvx___.quiet );
    assignin( 'caller', 'cvx_status', prob.status );
    assignin( 'caller', 'cvx_optval', prob.result );
end

% Copyright 2005 Michael C. Grant and Stephen P. Boyd. 
% See the file COPYING.txt for full copyright information.
% The command 'cvx_where' will show where this file is located.
