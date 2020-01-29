clear all;
clc;
close all;

% Preliminaries
currentFolder = pwd;
inputFilename = 'input.txt';

[maxAltitude, ...
C,...
initialAltitude,...
initialPressure,...
nodeSpacing,...
resultsToPlot,...
domainLength,...
numElements]= readInput(inputFilename);

% Discretize the domain
[nodalCoords, locationMatrix] = mesher(domainLength,numElements);

%%
% Compute the analytical solution
pressureAnalytical = analyticalSolution(C,...
                                        initialPressure,...
                                        nodalCoords);


%%
% Fractional

pressureFrac = fractional(C, initialPressure, domainLength, numElements, nodalCoords, numGP);
