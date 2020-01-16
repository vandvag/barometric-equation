function pressureBackward = backwardDiff(C,...
                                       initialPressure,...
                                       nodeCoords)
%backwardDiff: Calculates the solution of the ODE via the backward
%             difference method using the
%             initial conditions of the problem
%==========================================================================
%INPUT
%   C                  ... C = Mg/RT (1/m)
%   initialPressure    ... Initial pressure (bar)
%   nodeCoords         ... Domain Discretization (array)
% OUTPUT
%   pressureForward    ... Array of pressure computed at each node (bar)
%==========================================================================
% Initialize Arrays

numNodes = length(nodeCoords);
nodeSpacing = nodeCoords(2) - nodeCoords(1);

boundaryCond = zeros(numNodes, 1);

% Construct the system matrix

systemMatrix = diag(ones(numNodes,1), 0) + diag((-1/(1+C*nodeSpacing))*ones(numNodes-1,1),-1);

% Apply boundary conditions on system matrix and vector

boundaryCond(1) = initialPressure;

% Solve system

pressureBackward = systemMatrix \ boundaryCond;

% Apply pressure boundary condition

end

