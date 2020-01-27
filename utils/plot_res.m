function plot_res(nodalCoords,...
                  pressureAnalytical, ...
                  pressureForward, ...
                  pressureBackward, ...
                  pressureFEM, ...
                  pressureFrac, ...
                  resultsToPlot)
% Plot the solution of the problem for each node
%==========================================================================
%INPUT
%   nodalCoords: Coordinates of spatial nodes
%   pressureAnalytical: Pressure at each node (analytical)
%   pressureForward: Pressure at each node (forward difference method)
%   pressureBackward: Pressure at each node (backward difference method)
%   pressureFEM: Pressure at each node (FEM difference method)
%   pressureFrac: Pressure at each node (fractional derivation)
%   resultsToPlot: Array containing the ID of each method
%       (1-> Analytical)
%       (2-> Forward Difference)
%       (3-> Backward Difference)
%       (4-> FEM)
%       (5-> Fractional Calculus)
%==========================================================================
% OUTPUT
%   errForward: Relative error at each node (forward difference method)
%   errBackward: Relative Error at each node (backward difference method)
%   errFEM: Relative error at each node (FEM difference method)
%   errFrac: Relative error at each node (fractional derivation)
%==========================================================================                 
 
                  
figure()
title('Solution of Barometric Equation')
xlabel('Altitude h (m)')
ylabel('Pressure P (bar)')

hold on
for i=1:length(resultsToPlot)
    switch(resultsToPlot(i))
        case 1
            plot(nodalCoords, pressureAnalytical, 'DisplayName', 'Analytical Solution')
        case 2
            plot(nodalCoords, pressureForward, 'DisplayName', 'Forward Differences')
        case 3
            plot(nodalCoords, pressureBackward, 'DisplayName', 'Backward Differences')
        case 4
            plot(nodalCoords, pressureFEM,'--', 'DisplayName', 'FEM')
        case 5
            plot(nodalCoords, pressureFrac, 'DisplayName', 'Fractional')
    end
end


legend show
grid on

end
