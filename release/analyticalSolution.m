function pressureAnalytical = analyticalSolution(C,...
                                                 initialPressure,...
                                                 nodeCoords)
% Calculates the analytical solution given the
% initial conditions of the problem
%===============================================================================
%INPUT
%   C                  ... C = Mg/RT (1/m)
%   initialAltitude    ... Initial altitude (m)
%   initialPressure    ... Initial pressure (bar)
%   nodeSpacing        ... Nodal spacing, Schrittweite (m)
%   numSteps           ... Number of steps, nodes (-)
%===============================================================================
% OUTPUT
%   heightAnalytical   ... Array of heights where solution is calculated(m)
%   pressureAnalytical ... Array of pressure computed at each node (bar)
%===============================================================================

% Initialize arrays
numNodes = length(nodeCoords);
pressureAnalytical = zeros(numNodes, 1);

% Apply boundary conditions
pressureAnalytical(1) = initialPressure;

% Calculate the analytical solution at each point
for i=2:numNodes
    pressureAnalytical(i) = initialPressure * exp(-C*nodeCoords(i));
end

end
