function [Kg, bFEM] = boundaryConditions(initialPressure, Kg)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

Kg(1,:) = 0;
Kg(1,1) = 1;
bFEM = zeros(length(Kg), 1); bFEM(1) = initialPressure;

end

