function shapeF = shapeFncs(x, k, n, a)
% Evaluates the k-th shape function at given point x
%===============================================================================
% INPUT:
% x: Evaluation point
% k: k-th shape function to be evaluated
% n: Number of shape functions defined by the discretization
% a: Domain length
%===============================================================================
% OUTPUT:
% shapeF: Evaluation of the shape function at the point x
%===============================================================================

l = a / n;

if k == n
    if (n-1) * l <= x && x <= n*l
        shapeF = (x - (n-1) * l) / l;
    else
        shapeF = 0;
    end
else
    if (k-1) * l <= x && x <= k * l
        shapeF = (x - (k-1) * l) / l;
    elseif k * l < x && x <= (k + 1) * l
        shapeF = ((k+1)*l - x) / l;
    else
        shapeF = 0;
    end
end
end
