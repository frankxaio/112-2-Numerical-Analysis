function [x, iter] = Jacobi(A, b, es, maxit)
% Jacobi: Jacobi iteration method
%   x = Jacobi(A, b): Jacobi iteration
% input:
%   A = coefficient matrix
%   b = right hand side vector
%   es = stop criterion (default = 0.00001%)
%   maxit = max iterations (default = 50)
% output:
%   x = solution vector

if nargin < 2, error('at least 2 input arguments required'), end
if nargin < 4 || isempty(maxit), maxit = 50; end
if nargin < 3 || isempty(es), es = 0.00001; end

[m, n] = size(A);
if m ~= n, error('Matrix A must be square'); end

D = diag(diag(A));
R = A - D;

x = zeros(n, 1);
xold = x;

for iter = 1:maxit
    for i = 1:n
        x(i) = (b(i) - R(i,:) * xold) / A(i,i);
    end
    
    if norm(x - xold, inf) < es * norm(x, inf), break, end
    xold = x;
end
end