function y = imag( x )
error( cvx_verify( x ) );
y = cvx( problem( x ), size( x ), imag( cvx_basis( x ) ) );

% Copyright 2005 Michael C. Grant and Stephen P. Boyd. 
% See the file COPYING.txt for full copyright information.
% The command 'cvx_where' will show where this file is located.
