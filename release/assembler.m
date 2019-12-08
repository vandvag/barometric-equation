function Kg = assembler(C, elementLength, locationMatrix)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

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

