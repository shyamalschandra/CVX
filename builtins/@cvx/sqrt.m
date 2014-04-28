function y = sqrt( x )

%   Discipined convex programming information for SQRT:
%      SQRT(X) is log-concave and nondecreasing in X. Therefore, when used
%      in DCPs, X must be concave (or affine).
%   
%   Disciplined geometric programming information for SQRT:
%      SQRT(X) is log-log-affine and nondecreasing in X. Therefore, when
%      used in DGPs, X may be log-affine, log-convex, or log-concave.

persistent P
if isempty( P ),
    P.map = cvx_remap( { 'nonnegative' }, { 'l_valid' }, ...
        { 'r_affine', 'concave' } );
    P.funcs = { @sqrt_cnst, @sqrt_logv, @sqrt_affn };
end

try
     y = cvx_unary_op( P, x );
catch exc
    if strncmp( exc.identifier, 'CVX:', 4 ), throw( exc ); 
    else rethrow( exc ); end
end

function y = sqrt_cnst( x )
y = builtin( 'sqrt', x );

function y = sqrt_logv( x )
y = exp_nc( 0.5 * log( x ) );

function y = sqrt_affn( x ) %#ok
cvx_begin
    hypograph variable y( size(x) ) nonnegative_
    { y, 1, linearize( x ) } == rotated_lorentz( size(x), 0 );
cvx_end

% Copyright 2005-2014 CVX Research, Inc.
% See the file LICENSE.txt for full copyright information.
% The command 'cvx_where' will show where this file is located.
