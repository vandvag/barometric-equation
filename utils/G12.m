function g = G12(x, y, a)
% Evaluates the derivative G_{1/2} at points x, y
%===============================================================================
% INPUT:
% x: Evaluation point
% y: Evaluation point
% a: Domain length
%===============================================================================
% OUTPUT:
% g: Evaluation of the derivatve at points x, y
%===============================================================================

tau = pi / (4*a);

g = 1 / pi * log(tan(tau*(x+y)) / tan(tau*abs(x-y)));
end
