function pFrac = fractional(C, initialPressure, domainLength, numElements, nodalCoords)
% Calculates the solution of the ODE via the fractional calculus method
%==========================================================================


n = numElements;
c = C;
p0 = initialPressure;
a = domainLength;


% Gauss-Jacobi parameters
numGP = 50; % Number of Gauss Points
alpha = -0.5; % Alpha parameter of Gauss-Jacobi quadrature

% Calculation of the left-hand side
M = LHSFnc(n, a, numGP, alpha);

% Calculation of the right-hand side
bFrac = RHSFnc(n, a, c, p0, numGP, alpha);

% Solution of the system
pFrac = M \ bFrac;
pFracTrans = zeros(length(pFrac), 1);

% Transformation
for i=1:length(pFrac)
    pFracTrans(i) = initialPressure  - pFrac(i) * exp(- c * nodalCoords(i+1));
end
pFrac = [p0; pFracTrans];

end
