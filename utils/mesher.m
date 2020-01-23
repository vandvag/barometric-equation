function [nodalCoords, LocationMatrix] = mesher(l,nElem)
% Discretizes an 1D domain
%==========================================================================
%INPUT
%   l                  ... Length of the discretized domain (m)
%   nElem              ... Number of elements (m)
%OUTPUT
%   nodalCoords: array     ... The coordinates of every node (m)
%   LocationMatrix: array  ... Array containing the node IDs of each element
%==========================================================================
% Initialize Arrays
nodalCoords = zeros(nElem + 1, 1);
le = l / nElem; % Element length

for el=1:1:nElem+1
    nodalCoords(el) = (el-1) * le;
end

% Location Matrix for assembly information

LocationMatrix = zeros(2, nElem);

for el=1:1:nElem
    LocationMatrix(1,el) = el;
    LocationMatrix(2,el) = el+1;
end
end

