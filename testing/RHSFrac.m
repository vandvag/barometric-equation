% n = 20;
% c = 1;
% p0 = 1;
% a = n;
% l = a / n;
% tau = pi / (4*a);

numGP = 5;

alpha = 0.5;
[xj1, wj1] = gaussInt(numGP, alpha, 0);
shapeFncs1 = shapeFunctions(n, a, xj1);
[xj2, wj2] = gaussInt(numGP, 0, alpha + 1);
shapeFncs2 = shapeFunctions(n, a, xj2);
[xj3, wj3] = gaussInt(numGP, 0, alpha);
shapeFncs3 = shapeFunctions(n, a, xj3);
[xj4, wj4] = gaussInt(numGP, alpha + 1, 0);
shapeFncs4 = shapeFunctions(n, a, xj4);


bFractional = zeros(n,1);

% Main Loop
for i=1:n
    sum = 0;
    for gx=1:numGP % xi
        for gy=1:numGP % eta
            x = a / 2 * (1 + xj2(gy));
            y = a / 4 * (1 + xj2(gy)) * (1 + xj1(gx));

            sum = sum + p0 * c^2 / pi * (a / 4) ^ (1+alpha) * wj1(gx) * wj2(gy) * shapeFncs(i, gy) * log(tan(tau*(x+y)) / tan(tau*abs(x-y))) * exp(c*y) * abs(x-y)^(-alpha);

            x = a / 2 * (1 + xj4(gy));
            y = a / 4 * (1 + xj4(gy)) * (1 + xj3(gx));

            sum = sum + p0 * c^2 / pi * (a / 4) ^ (1+alpha) * wj3(gx) * wj4(gy) * shapeFncs(i, gy) * log(tan(tau*(x+y)) / tan(tau*abs(x-y))) * exp(c*y) * abs(x-y)^(-alpha);
        end
    end
    bFractional(i) = sum;
end

