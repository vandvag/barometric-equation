function p_frac = fractional(C, initialPressure, domainLength, numElements)
% Calculates the solution of the ODE via the fractional calculus method
%==========================================================================


n = numElements;
c = C;
p0 = initialPressure;
a = domainLength;


% Gauss-Jacobi parameters
numGP = 50; % Number of Gauss Points
alpha = -0.5; % Alpha parameter of Gauss-Jacobi quadrature
M = LHSFnc(n, a, numGP, alpha);


bFrac = RHSFnc(n, a, c, p0, numGP, alpha);

p_frac = M \ bFrac;
p_frac = [p0; p_frac];
end
