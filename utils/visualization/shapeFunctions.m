function shapeFncs = shapeFunctions(n,a,x)
% Evaluates the shape functions at specific positions
%===============================================================================
% INPUT
%   n: Number of elements
%   a: Length of the domain
%   x: Vector containing the points at which the shape functions will be evaluated
%===============================================================================
% OUPUT
%   shapeFncs: Array containing the value of each shape function at each point x
%===============================================================================

l = a / n;
shapeFncs = zeros(n, length(x));

for k=1:n
   for i=1:length(x)
      if ((k-1) * l <= x(i) && x(i) < k * l)
          shapeFncs(k, i) = x(i) / l - (k-1);
      elseif (k * l <= x(i) && x(i) <= (k+1) * l)
          shapeFncs(k, i) = (k+1) - x(i) / l;
      end
   end
end
end

