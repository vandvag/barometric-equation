% n = 20;
% c = 1;
% p0 = 1;
% a = n;
% l = a / n;
% tau = pi / (4*a);

% numGP = 5;

alpha = -0.5;
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
            bFrac(k) = bFrac(k) + 2 * p0 * c^2 * (a/4)^(2+alpha) * shapeFncs(x1, k, n, a) * G12(x1,y1, a) * exp(c*y1) * (abs(x1 - y1))^(-alpha) * wj1(gx) * wj2(gy);
            % Second sum
            bFrac(k) = bFrac(k) + 2 * p0 * c^2 * (a/4)^(2+alpha) * shapeFncs(x2, k, n, a) * G12(x2,y2, a) * exp(c*y2) * (abs(x2 - y2))^(-alpha) * wj3(gx) * wj4(gy);
        end
    end
end

bFrac