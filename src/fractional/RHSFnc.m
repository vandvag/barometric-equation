function bFrac = RHSFnc(n, a, c, p0, numGP, alpha)
% Assembles the global stiffness matrix
%==========================================================================
% INPUT
%   n: Number of elements
%   a: Domain length
%   c: Differential equation constant
%   p0: Initial pressure
%   numGP: Number of Gauss points
%   alpha: Exponent for Gauss-Jacobi quadrature
%==========================================================================
% OUPUT
%   bFrac: Global right-hand side vector
%==========================================================================

% Gauss-Jacobi integration nodes/weights
[xj1, wj1] = gaussInt(numGP, alpha, 0);
[xj2, wj2] = gaussInt(numGP, 0, alpha + 1);
[xj3, wj3] = gaussInt(numGP, 0, alpha);
[xj4, wj4] = gaussInt(numGP, alpha + 1, 0);


bFrac = zeros(n,1);

% Main Loop
for k=1:n
    for gx=1:numGP % xis
        for gy=1:numGP % etas
            % Coordinate transformations
            x1 = a / 2 * (1 + xj2(gy));
            y1 = a / 4 * (1 + xj2(gy)) * (1 + xj1(gx));
            x2 = a / 2 * (1 + xj4(gy));
            y2 = a / 4 * (1 - xj4(gy)) * xj3(gx) + a / 4 * (3 + xj4(gy));

            % First sum

            % Transformation proposed by Matthias Hinze
            bFrac(k) = bFrac(k) - 2 * p0 * c^2 / (1+c*a) * (a/4)^(2+alpha) * shapeFncs(x1, k, n, a) * G12(x1,y1, a) * exp(c*y1) * (1+c*(y1-a)) * (abs(x1 - y1))^(-alpha) * wj1(gx) * wj2(gy);

            % Second sum
            % Transformation proposed by Matthias Hinze
            bFrac(k) = bFrac(k) - 2 * p0 * c^2 / (1+c*a) * (a/4)^(2+alpha) * shapeFncs(x2, k, n, a) * G12(x2,y2, a) * exp(c*y2) * (1+c*(y2-a)) * (abs(x2 - y2))^(-alpha) * wj3(gx) * wj4(gy);
        end
    end
end
end