function Kg = assembler(C, elementLength, locationMatrix)
% Assembles the global stiffness matrix
%==========================================================================
% INPUT
% C: Constant C from the differential equation
% elementLength: The length of one element
% locationMatrix: Array containing the IDs of the nodes of each element
%==========================================================================
% OUPUT
% Kg: Global stiffness matrix
%==========================================================================

numElements = length(locationMatrix);

Kg = zeros(numElements + 1);
Ke = 1 / 6 * [-3 + 2 * C * elementLength, 3 + C * elementLength; -3 + C * elementLength, 3 + 2 * C * elementLength];

for i=1:1:numElements
    for j=1:2
        for k=1:2
            Kg(locationMatrix(j,i), locationMatrix(k,i)) = Kg(locationMatrix(j,i), locationMatrix(k,i)) + Ke(j,k);
        end
    end
end

end

