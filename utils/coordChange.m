function returnedValue = coordChange(lowerBound,upperBound, value)
% Performs a coordinate change as described by the Gauss quadrature rule
% from the [lowerBound, upperBound] interval to [-1, 1]
% https://en.wikipedia.org/wiki/Gaussian_quadrature
%===============================================================================
% INPUT:
% lowerBound: Lower bound of the interval
% upperBound: Upper bound of the interval
% value: value inside the interval
%===============================================================================
% OUTPUT
% returnedValue: corresponding value to input in the [-1, 1] interval
%===============================================================================

returnedValue = (upperBound - lowerBound) / 2 * value + (upperBound + lowerBound) / 2;
end

