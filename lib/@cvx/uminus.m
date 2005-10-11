function z = uminus( x )
error( cvx_verify( x ) );
z = cvx( problem( x ), x.size_, -x.basis_ );

% Copyright 2005 Michael C. Grant and Stephen P. Boyd. 
% See the file COPYING.txt for full copyright information.
% The command 'cvx_where' will show where this file is located.
