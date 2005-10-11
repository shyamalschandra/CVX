function z = mpower( x, y )
error( cvx_verify( x, y ) );
[ prob, x, y ] = cvx_operate( [], x, y );

%
% Check sizes
%

sx = size( x );
sy = size( y );
if length( sx ) > 2 | length( sx ) > 2,
    error( 'Not defined for N-D matrices.' );
end
xs = all( sx == 1 );
ys = all( sy == 1 );
if xs,
    sz = sy;
elseif ys,
    sz = sx;
else,
    error( 'At least one operand must be scalar.' );
end

%
% Enforce DCP rules
%

xc = cvx_isconstant( x );
yc = cvx_isconstant( y );
if xc & yc,
    z = cvx_constant( x ) ^ cvx_constant( y );
elseif ~yc | ~xs | ~ys | ~isreal( x ) | cvx_constant( y ) ~= 2,
    error( sprintf( 'Disciplined convex programming error:\n    Use of ''^'' is limited to ''x^2'', for x scalar, real, and affine.' ) );
else,
    z = square( x );
end

% Copyright 2005 Michael C. Grant and Stephen P. Boyd. 
% See the file COPYING.txt for full copyright information.
% The command 'cvx_where' will show where this file is located.
