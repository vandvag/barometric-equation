function M = LHSFnc(n, a, numGP, alpha)

l = a / n;

%alpha = -0.5, beta = 0
[xj1, wj1] = gaussInt(numGP, alpha, 0);
% alpha = 0, beta = -0.5
[xj2, wj2] = gaussInt(numGP, 0, alpha);

% Defining M matrix

M = zeros(n,n);

% This only works up to k=n-1
for k=1:(n-1)
    for m=k:n % Calculate only the upper half of M (since M symmetric)
        % Gauss Loop
        for gx=1:numGP
            x1 = k*l / 2 * xj1(gx) + k*l/2;
            x2 = (a-k*l)/2 * xj2(gx) + (a + k*l) / 2;

            % first part of the sum
            M(k,m) = M(k,m) + (k*l/2)^(1+alpha) * wj1(gx) * matInts(x1, m, n, a) * shapeFncs(x1, k, n, a) * (abs(x1-k*l))^(-alpha);
            % second part of the sum
            M(k,m) = M(k,m) + ((a-k*l)/2)^(1+alpha) * wj2(gx) * matInts(x2, m, n, a) * shapeFncs(x2, k, n, a) * (abs(x2-k*l))^(-alpha);
        end
    end
end

% Special case for k=n
k = n; m = n;
for gx=1:numGP
    x = a / 2 * xj1(gx) + a  / 2;
    M(n,n) = M(n,n) + (a/2)^(1+alpha) * wj1(gx) * shapeFncs(x, n, n, a) * matInts(x, n, n, a)  * (a - x)^(-alpha);

% Make M symmetric
for i=1:n
    for j=1:n
        M(j,i) = M(i,j);
    end
end
end