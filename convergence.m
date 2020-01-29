clear all
close all
clc

inputFilename = 'input.txt';

[maxAltitude, ...
C,...
initialAltitude,...
initialPressure,...
nodeSpacing,...
resultsToPlot,...
domainLength,...
numElements]= readInput(inputFilename);

numElements = linspace(20, 200, 10);

maxerrForward = zeros(length(numElements), 1);
maxerrBackward = zeros(length(numElements), 1);
maxerrFEM = zeros(length(numElements), 1);
maxerrFrac = zeros(length(numElements), 1);
meanerrForward = zeros(length(numElements), 1);
meanerrBackward = zeros(length(numElements), 1);
meanerrFEM = zeros(length(numElements), 1);
meanerrFrac = zeros(length(numElements), 1);

for i=1:length(numElements)
%%
% Discretize the domain
[nodalCoords, locationMatrix] = mesher(domainLength,numElements(i));

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

pressureFrac = fractional(C, initialPressure, domainLength, numElements(i), nodalCoords);

%%
% Find relative error
[errForward,...
 errBackward, ...
 errFEM, ...
 errFrac] = find_error(nodalCoords, pressureAnalytical, pressureForward,...
 pressureBackward, pressureFEM, pressureFrac);

maxerrForward(i) = max(errForward);
maxerrBackward(i) = max(errBackward);
maxerrFEM(i) = max(errFEM);
maxerrFrac(i) = max(errFrac);
meanerrForward(i) = mean(errForward);
meanerrBackward(i) = mean(errBackward);
meanerrFEM(i) = mean(errFEM);
meanerrFrac(i) = mean(errFrac);
end

figure()
semilogy(numElements, maxerrForward, 'DisplayName', 'Forward')
hold on
semilogy(numElements, maxerrBackward, 'DisplayName', 'Backward')
semilogy(numElements, maxerrFEM, 'DisplayName', 'FEM')
semilogy(numElements, maxerrFrac, 'DisplayName', 'Fractional')
xlabel('Number of elements (-)')
ylabel('log(error)')
title('Max error')
legend
grid on

figure()
semilogy(numElements, meanerrForward, 'DisplayName', 'Forward')
hold on
semilogy(numElements, meanerrBackward, 'DisplayName', 'Backward')
semilogy(numElements, meanerrFEM, 'DisplayName', 'FEM')
semilogy(numElements, meanerrFrac, 'DisplayName', 'Fractional')
xlabel('Number of elements (-)')
ylabel('log(error)')
title('Mean error')
legend
grid on