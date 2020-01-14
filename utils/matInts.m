function matInt = matInts(y, m, n, a)
% Evaluates the m-th [A*A]phi term at given point y
%===============================================================================
% INPUT:
% y: Evaluation point
% m: m-th shape function to be evaluated
% n: Number of shape functions defined by the discretization
% a: Domain length
%===============================================================================
% OUTPUT:
% matInt: Evaluation of the shape function at the point y
%===============================================================================

l = a / n;
tau = pi / (4*a);

if m == n
    matInt = 1 / (pi * l) * log((tan(tau*(n*l+y)) * tan(tau*abs((n-1)*l-y))) / (tan(tau*abs(n*l-y)) * tan(tau*((n-1)*l+y))));
else
    matInt = 1/(pi*l) * (log(tan(tau*(m*l+y)) * tan(tau*abs((m-1)*l-y)) / (tan(tau*abs(m*l-y)) * tan(tau*((m-1)*l+y)))) - log(tan(tau*((m+1)*l+y)) * tan(tau*abs(m*l-y)) / (tan(tau*abs((m+1)*l-y)) * tan(tau*(m*l+y)))));
