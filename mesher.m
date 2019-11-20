function [nodalCoords, LocationMatrix] = mesher(l,nElem)
%mesh Discretizes an 1D domain
%==========================================================================
%INPUT
%   l                  ... Length of the discretized domain (m)
%   nElem              ... Number of elements (m)
%OUTPUT
%   nodalCoords: array     ... The coordinates of every node (m)
%   LocationMatrix: array  ... Array of pressure computed at each node (bar)
%==========================================================================
% Initialize Arrays
nodalCoords = zeros(1,nElem + 1);
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

