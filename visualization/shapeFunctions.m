function [x, shapeFunctions] = shapeFunctions(n,a)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

l = a / n;
% Create domain discretization
numPoints = 1000;

x = linspace(0, a, numPoints);
shapeFunctions = zeros(n, length(x));

for k=1:n
   for i=1:length(x)
      if ((k-1) * l <= x(i) && x(i) < k * l)
          shapeFunctions(k, i) = x(i) / l - (k-1);
      elseif (k * l <= x(i) && x(i) <= (k+1) * l)
          shapeFunctions(k, i) = (k+1) - x(i) / l;
      end
   end
end
end

