function p_FEM = FEM(C, initialPressure, nodeCoords, locationMatrix)
%FEM: Calculates the solution of the ODE via the finite element
%      method using the initial conditions of the problem
%==========================================================================
%INPUT
%   C                  ... C = Mg/RT (1/m)
%   initialAltitude    ... Initial altitude (m)
%   initialPressure    ... Initial pressure (bar)
%   nodeCoords         ... Nodal spacing, Schrittweite (m)
%   locationMatrix     ... Number of steps, nodes (-)
%OUTPUT
%   p_FEM              ... Array of pressure computed at each node (bar)
%==========================================================================
% Initialize Arrays

% Build the System  A_FEM*pressureFEM = b_FEM with the unknown vector pressureFEM

% Step 1: Discretization (Done in mesher function)
numNodes = length(nodeCoords);
nodeSpacing = nodeCoords(2) - nodeCoords(1);

% Step 2: Assembly of system matrix 
A_FEM = assembler(C, nodeSpacing, locationMatrix);

% Step 3: Apply boundary conditions
[A_FEM, bFEM] = boundaryConditions(initialPressure, A_FEM);
% Step 4: Solve for pressure
p_FEM = A_FEM \ bFEM;
end




