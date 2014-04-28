function cvx_optpnt = exponential( varargin )

%EXPONENTIAL   Exponential cone.
%   EXPONENTIAL, called with no arguments, creates three scalar variables X,
%   Y, and Z and constraints them to lie in an exponetial cone. That is,
%   given the declaration
%       variables x y z
%       {x,y,z} == exp_cone
%   constraints the variables to satisfy
%       y*exp(x/y) <= z
%       y > 0
%   The inequality form does not obey the disciplined convex programming
%   ruleset, but a function EXP_P has been created to represent this
%   computation; so the set declaration above is equivalent to
%       EXP_P(X,Y) <= Z
%   EXP_CONE(SX), where SX is a size vector, creates three array variables
%   X, Y, and Z, each of size SX, which are constrained elementwise to
%   satisfy EXP_P(X,Y) <= Z. If SX is empty, then SX=[1,1] is assumed.

cvx_expert_check( 'exponential' );
sx = cvx_get_dimlist( varargin, 'default', [1,1] ); %#ok
cvx_begin set
    variable x( sx )
    variable y( sx ) nonnegative_
    variable z( sx ) nonnegative_
    [ tx, dummy ] = find( cvx_basis( x ) ); %#ok
    [ ty, dummy ] = find( cvx_basis( y ) ); %#ok
    [ tz, dummy ] = find( cvx_basis( z ) ); %#ok
    newnonl( cvx_problem, 'exponential', [ tx(:)' ; ty(:)' ; tz(:)' ] );
    cvx___.canslack( tx ) = false;
    cvx___.canslack( ty ) = false;
cvx_end

cvx_optpnt = cvxtuple( struct( 'x', x, 'y', y, 'z', z ) );

% Copyright 2005-2014 CVX Research, Inc.
% See the file LICENSE.txt for full copyright information.
% The command 'cvx_where' will show where this file is located.
