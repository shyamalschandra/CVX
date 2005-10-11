function [ cvx_optval, success ] = quad_form( x, Q, tol )
error( nargchk( 2, 3, nargin ) );
if nargin < 3, tol = 4 * eps; end

%QUAD_FORM quadratic form.
%
%   QUAD_FORM(x,Q) is x'*((Q+Q'/2))*x = real(x'*Q*x).
%
%   x must be a row or column vector, and Q must either be a scalar or
%   a square matrix with the same number of rows as x(:).
%
%   QUAD_FORM(x,Q,tol) uses the tolerance TOL when testing if Q is positive
%   or negative semidefinite (when necessary; see below). That is:
%       if min(eig(Q))>=-tol*max(eig(Q)), then Q is considered PSD;
%       if max(eig(Q))<=-tol*min(eig(Q)), then Q is considered NSD.
%   If not supplied, then tol=4*eps is assumed. This form should obviously
%   be used with care; if tol is chosen too large, an incorrect result will
%   be produced. However, the result will remain convex (or concave)
%   regardless, because offending eigenvalues will be forced to zero.
%
%   Disciplined quadratic programming information:
%       QUAD_FORM(x,Q) is neither convex nor concave in x and Q jointly,
%       so at least one of the two arguments must be constant.
%
%       If Q is constant, then QUAD_FORM is convex if Q is positive
%       semidefinite, and concave if Q is negative semidefinite. An error 
%       is generated if Q is indefinite (unless x is also constant). 
%       QUAD_FORM is nonmonotonic in x, so x must be affine.
%       
%       If x is constant, then QUAD_FORM is affine in Q. The monotonicity
%       of QUAD_FORM depends on the precise values of x in this case, which
%       in turn govern whether the elements of Q can be convex, concave, or
%       affine. An error message will be generated if an inappropriate sum
%       of convex and concave terms occurs.

%
% Check sizes and types
%

sx = size( x );
if length( sx ) ~= 2 | all( sx > 1 ),
    error( 'The first argument must be a row or column.' );
else
    sx = prod( sx );
end

sQ = size( Q );
if length( sQ ) ~= 2 | sQ( 1 ) ~= sQ( 2 ),
    error( 'The second argument must be a scalar or a square matrix.' );
elseif sQ( 1 ) ~= sx & sQ( 1 ) ~= 1,
    error( 'Sizes are incompatible.' );
else,
    sQ = sQ( 1 );
end

success = true;
if cvx_isconstant( x ),
    
    if cvx_isconstant( Q ),
        
        %
        % Constant case
        %

        cvx_optval = quad_form( cvx_constant( x ), cvx_constant( Q ) );
        
    elseif isreal( Q ) | isreal( x ),
        
        %
        % Constant x, affine Q, real case
        %
        
        x = real( x( : ) );
        Q = real( Q );
        cvx_optval = x' * ( Q * x );
        
    else,
        
        %
        % Constant x, affine Q, complex case
        %
        
        xR = real( x( : ) );
        xI = imag( x( : ) );
        cvx_optval = xR' * ( real( Q ) * xR ) + xI' * ( imag( Q ) * xI );
        
    end
        
else,

    %
    % Constant Q, affine x
    % 
    
    if ~cvx_isaffine( x ),
        error( 'First argument must be affine.' );
    end

    x = x( : );
    Q = cvx_constant( Q );
    Q = 0.5 * ( Q + Q' );
    nnzs = find( any( Q ~= 0, 2 ) );
    Q = Q( nnzs, nnzs );
    x = x( nnzs, : );
    
    [ V, D ] = eig( full( Q ) );
    D = diag( D );
    D = D( : );

    %
    % Branch for positive and negative semidefinite
    %

    if D(1) >= -tol * D(end),
        
        % Q positive semidefinite;
        cvx_optval = sum_square( sqrt( max( D, 0 ) ) .* ( V' * x( : ) ) );

    elseif D(end) <= -tol * D(1),

        % Q negative semidefinite
        cvx_optval = - sum_square( sqrt( max( -D, 0 ) ) .* ( V' * x( : ) ) );

    elseif nargout > 1,

        success = false;
        cvx_optval = [];
        
    else,
        
        error( 'The second argument must be positive or negative semidefinite.' );

    end

end

% Copyright 2005 Michael C. Grant and Stephen P. Boyd. 
% See the file COPYING.txt for full copyright information.
% The command 'cvx_where' will show where this file is located.
