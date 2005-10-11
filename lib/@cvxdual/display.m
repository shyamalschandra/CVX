function display( x )
nm = inputname( 1 );
usename = ~isequal( nm, name( x ) );
long = ~isequal(get(0,'FormatSpacing'),'compact');
if long, disp( ' ' ); end
disp([nm ' =']);
if long, disp( ' ' ); end
disp(x,'    ',usename)
if long, disp( ' ' ); end

% Copyright 2005 Michael C. Grant and Stephen P. Boyd. 
% See the file COPYING.txt for full copyright information.
% The command 'cvx_where' will show where this file is located.
