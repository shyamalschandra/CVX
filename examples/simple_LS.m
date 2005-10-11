echo on

% A simple least-squares problem

n = 100;
A = randn(2*n,n);
b = randn(2*n,1);
cvx_begin
   variable x(n)
   minimize( norm( A*x-b ) )
cvx_end

echo off
