 function [maxAltitude, ...
          C,...
          initialAltitude,...
          initialPressure,...
          nodeSpacing,...
          resultsToPlot,...
          domainLength,...
          numElements] = readInput(inputFilename)
%readInput: Reads the values given in the input file
%---------------------------------------------------
%INPUT
%   inputFilename   ... Name of the input file
%
%OUTPUT
%   maxAltitude     ... Maximum altitude (m)
%   C               ... C = Mg/RT (1/m)
%   initialAltitude ... Initial altitude (m)
%   initialPressure ... Initial pressure (bar)
%   nodeSpacing     ... Nodal spacing, Schrittweite (m)
%   numSteps        ... Number of elements (-)

inputFileId = fopen(inputFilename, 'r');

maxAltitude = fscanf(inputFileId, 'MAX_ALT = %f', 1);
C = fscanf(inputFileId, '\nC = %f', 1);
initialAltitude = fscanf(inputFileId, '\nINIT_ALT = %f', 1);
initialPressure = fscanf(inputFileId, '\nINIT_PRESS = %f', 1);
nodeSpacing = fscanf(inputFileId, '\nND_SPACING = %f', 1);
resultsToPlot = fscanf(inputFileId, '\nPLOTS = %d %d %d %d\n',4);
domainLength = maxAltitude - initialAltitude;
numElements = (domainLength / nodeSpacing);

fclose(inputFileId);

end

