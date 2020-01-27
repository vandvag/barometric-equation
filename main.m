clear all;
clc;
close all;

% Preliminaries
currentFolder = pwd;
inputFilename = 'input.txt';

%%
% Read the input from the input file
[maxAltitude, ...
C,...
initialAltitude,...
initialPressure,...
nodeSpacing,...
resultsToPlot,...
domainLength,...
numElements]= readInput(inputFilename);

% Get only the unique inputs for the plots
resultsToPlot = unique(resultsToPlot);

%%
% Discretize the domain
[nodalCoords, locationMatrix] = mesher(domainLength,numElements);

%%
% Compute the analytical solution
pressureAnalytical = analyticalSolution(C,...
                                        initialPressure,...
                                        nodalCoords);

%%
% Compute the solution via the forward differences method
pressureForward = forwardDiff(C,...
                              initialPressure,...
                              nodalCoords);

%%
% Compute the solution via the backwards differences method
pressureBackward = backwardDiff(C,...
                                initialPressure,...
                                nodalCoords);

%%
% Compute the solution via the Finite Element Method

pressureFEM = FEM(C, initialPressure, nodalCoords, locationMatrix);

%%
% Fractional

pressureFrac = fractional(C, initialPressure, domainLength, numElements, nodalCoords);
%%
% Plot Results

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

%%
% Error plot

[errForward,...
 errBackward, ...
 errFEM, ...
 errFrac] = plot_errors(nodalCoords, pressureAnalytical, pressureForward,...
                        pressureBackward, pressureFEM, pressureFrac);

% Store results
storeResFlag = input('Do you want to store the results?(y/n) ', 's');

if storeResFlag == 'y' || storeResFlag == 'Y'
    disp('Storing results...')
    % Store pressures
    res = [nodalCoords, pressureAnalytical, pressureForward, pressureBackward, pressureFEM, pressureFrac];
    labels = ["Coords", "Analytical", "Forward", "Backward", "FEM", "Frac"];
    writematrix([labels; res],'pressure.dat', 'Delimiter', 'tab');

    % Store erorrs
    res = [nodalCoords, errForward, errBackward, errFEM, errFrac];
    labels = ["Coords", "err_forward", "err_backward", "err_FEM", "err_frac"];
    writematrix([labels; res],'error.dat', 'Delimiter', 'tab');
else
    disp('Process finished!')
end