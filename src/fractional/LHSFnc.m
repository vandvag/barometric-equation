function M = LHSFnc(n, a, numGP, alpha)
% Calculates the left-hand side of the fractional calculus derivation
%==========================================================================
% INPUT
% n: Number of elements
% a: Domain length
% numGP: Number of Gauss Points
% alpha: Exponent for Gauss-Jacobi quadrature
%==========================================================================
% OUPUT
% M: Global system matrix
%==========================================================================

l = a / n; % Element length

%alpha = -0.5, beta = 0
[xj1, wj1] = gaussInt(numGP, alpha, 0);
% alpha = 0, beta = -0.5
[xj2, wj2] = gaussInt(numGP, 0, alpha);

% Defining M matrix

M = zeros(n,n);

% This only works up to k=n-1
for k=1:n
    for m=k:n % Calculate only the upper half of M (since M symmetric)
        % Gauss Loop
        for gx=1:numGP
            x1 = l / 2 * xj1(gx) + (2*k-1) / 2 * l;
            x2 = l / 2 * xj2(gx) + (2*k+1) / 2 * l;

            % first part of the sum
            M(k,m) = M(k,m) + (l/2)^(1+alpha) * wj1(gx) * matInts(x1, m, n, a) * shapeFncs(x1, k, n, a) * (abs(x1-k*l))^(-alpha);
            % second part of the sum
            M(k,m) = M(k,m) + (l/2)^(1+alpha) * wj2(gx) * matInts(x2, m, n, a) * shapeFncs(x2, k, n, a) * (abs(x2-k*l))^(-alpha);
        end
    end
end


% Make M symmetric
for i=1:n
    for j=1:n
        M(j,i) = M(i,j);
    end
end
end

