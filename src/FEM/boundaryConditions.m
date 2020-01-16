function [Kg, bFEM] = boundaryConditions(initialPressure, Kg)
% Apply the boundary conditions for the problem
%==========================================================================
% INPUT
% initialPressure: The pressure boundary condition
% Kg: Global stiffness matrix
%==========================================================================
% OUTPUT
% Kg: Global stiffness matrix after application of boundary conditions
% bFEM: Right-hand side vector for the FEM implementation
%==========================================================================

Kg(1,:) = 0;
Kg(1,1) = 1;
bFEM = zeros(length(Kg), 1); bFEM(1) = initialPressure;

end

