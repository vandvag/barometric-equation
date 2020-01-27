function [errForward,...
          errBackward, ...
          errFEM, ...
          errFrac] = find_error(nodalCoords,...
                                pressureAnalytical,... 
                                pressureForward,...
                                pressureBackward, ...
                                pressureFEM, ... 
                                pressureFrac)
% Calculates the relative error of each method compared to the analytical
% solution
%==========================================================================
%INPUT
%   nodalCoords: Coordinates of spatial nodes
%   pressureAnalytical: Pressure at each node (analytical)
%   pressureForward: Pressure at each node (forward difference method)
%   pressureBackward: Pressure at each node (backward difference method)
%   pressureFEM: Pressure at each node (FEM difference method)
%   pressureFrac: Pressure at each node (fractional derivation)
%==========================================================================
% OUTPUT
%   errForward: Relative error at each node (forward difference method)
%   errBackward: Relative Error at each node (backward difference method)
%   errFEM: Relative error at each node (FEM difference method)
%   errFrac: Relative error at each node (fractional derivation)
%==========================================================================

errForward = abs((pressureForward - pressureAnalytical) ./ pressureAnalytical);
errBackward = abs((pressureBackward - pressureAnalytical) ./ pressureAnalytical);
errFEM = abs((pressureFEM - pressureAnalytical) ./ pressureAnalytical);
errFrac = abs((pressureFrac - pressureAnalytical) ./ pressureAnalytical);

end