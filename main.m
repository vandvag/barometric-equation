clear all;
clc;
close all;

% Preliminaries
currentFolder = pwd;
inputFilename = 'input.txt';

% Check if out directory exists
if ~exist('out', 'dir')
    mkdir('out')
end

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
% Find relative error
[errForward,...
 errBackward, ...
 errFEM, ...
 errFrac] = find_error(nodalCoords, pressureAnalytical, pressureForward,...
 pressureBackward, pressureFEM, pressureFrac);

% Plot Results
plot_res(nodalCoords,...
pressureAnalytical, ...
pressureForward, ...
pressureBackward, ...
pressureFEM, ...
pressureFrac, ...
resultsToPlot);

plot_errors(nodalCoords, pressureAnalytical, pressureForward,...
                        pressureBackward, pressureFEM, pressureFrac);

%%
% Store results
storeResFlag = input('Do you want to store the results?(y/n) ', 's');

if storeResFlag == 'y' || storeResFlag == 'Y'
    disp('Storing results...')
    % Store pressures
    res = [nodalCoords, pressureAnalytical, pressureForward, pressureBackward, pressureFEM, pressureFrac];
    labels = ["Coords", "Analytical", "Forward", "Backward", "FEM", "Frac"];
    writematrix([labels; res],'out/pressure.dat', 'Delimiter', 'tab');

    % Store erorrs
    res = [nodalCoords, errForward, errBackward, errFEM, errFrac];
    labels = ["Coords", "err_forward", "err_backward", "err_FEM", "err_frac"];
    writematrix([labels; res],'out/error.dat', 'Delimiter', 'tab');
else
    disp('Process finished!')
end