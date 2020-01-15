clear all

n = 20;
c = 1.1865e-4;
p0 = 1.013;
a = 10000;
l = a / n;
tau = pi / (4*a);

numGP = 50;
alpha = -0.5;

%alpha = -0.5, beta = 0
[xj1, wj1] = gaussInt(numGP, alpha, 0);
% alpha = 0, beta = -0.5
[xj2, wj2] = gaussInt(numGP, 0, alpha);

% Defining M matrix

M = zeros(n,n);

for k=1:n
    for m=k:n % Calculate only the upper half of M (since M symmetric)
        % Gauss Loop
        for gx=1:numGP
            x1 = l/2 * xj1(gx) + (2*k-1)*l/2;
            x2 = l/2 * xj2(gx) + (2*k+1)*l/2;

            % first part of the sum
            M(k,m) = M(k,m) + wj1(gx) * matInts(x1, m, n, a) * shapeFncs(x1, k, n, a) * (l/2)^(1+alpha);
            % second part of the sum
            M(k,m) = M(k,m) + wj2(gx) * matInts(x2, m, n, a) * shapeFncs(x2, k, n, a) * (l/2)^(1+alpha);
        end
    end
end

% Make M symmetric
for i=1:n
    for j=1:n
        M(j,i) = M(i,j);
    end
end
M
