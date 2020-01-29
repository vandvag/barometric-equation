function pFrac = fractional(C, initialPressure, domainLength, numElements, nodalCoords, numGP)
%==========================================================================
% Calculates the solution of the ODE via the fractional calculus method
%==========================================================================
% INPUT
%   C: C = Mg/RT (1/m)
%   initialPressure: Initial pressure (bar)
%   domainLength: Lenght of the domain (m)
%   numElements: Number of elements used (-)
%   nodalCoords: Coordinates of the nodes
%==========================================================================
% OUPUT
%   pFrac: pressure obtained via the fractional calculus approach
%==========================================================================


n = numElements;
c = C;
p0 = initialPressure;
a = domainLength;


% Gauss-Jacobi parameters
% numGP = 50; % Number of Gauss Points
alpha = -0.5; % Alpha parameter of Gauss-Jacobi quadrature

% Calculation of the left-hand side
M = LHSFnc(n, a, numGP, alpha);

% Calculation of the right-hand side
bFrac = RHSFnc(n, a, c, p0, numGP, alpha);

% Solution of the system
pFrac = M \ bFrac;
pFrac = [0; pFrac]; % Application of the boundary condition (g)
% pFrac = [p0; pFrac];
pFracTrans = zeros(length(pFrac), 1);

% Transformation (as described in the report) (Wrong)
% for i=1:length(pFrac)
%     pFracTrans(i) = initialPressure  - pFrac(i) * exp(- c * nodalCoords(i+1));
% end

% Transformation (Matthias Hinze)
for i=1:length(pFrac)
    pFrac(i) = initialPressure  + pFrac(i) * exp(- c * nodalCoords(i)) - c*p0/(1+c*a)*nodalCoords(i);
end
end
