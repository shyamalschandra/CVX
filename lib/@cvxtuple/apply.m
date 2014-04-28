function y = apply( func, x )
y = do_apply( func, x.value_ );

function y = do_apply( func, x )
switch class( x ),
    case 'struct',
        y = cell2struct( do_apply( func, struct2cell( x ) ), fieldnames( x ), 1 );
    case 'cell',
        y = cellfun( @(z)do_apply( func, z ), x, 'UniformOutput', false );
    otherwise,
        y = feval( func, x );
end

% Copyright 2005-2014 CVX Research, Inc. 
% See the file LICENSE.txt for full copyright information.
% The command 'cvx_where' will show where this file is located.
