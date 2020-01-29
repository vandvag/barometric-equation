clear all;
clc;
close all;

% Preliminaries
currentFolder = pwd;
inputFilename = 'input.txt';

numGP = 2:1:100;
maxerr = zeros(length(numGP), 1);

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


for i=1:length(numGP)
%%
% Fractional
pressureFrac = fractional(C, initialPressure, domainLength, numElements, nodalCoords, numGP(i));
errFrac = abs((pressureFrac - pressureAnalytical) ./ pressureAnalytical);
maxerr(i) = max(errFrac);
end

plot(numGP, maxerr)
xlabel('Number of Gauss points')
ylabel('error')
title('Maximum error in fractional derivation')