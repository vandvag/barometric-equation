clear

n = 2;
a = 2;
l = a / n;
tau = pi / (4*a);

% Define the functions
phi11 = @(x) x / l;
phi12 = @(x) 2 - x/l;
phi21 = @(x) 0;
phi22 = @(x) x / l - 1;
matInt1 = @(x, n) 1/(pi*l) * (log((tan(tau*(n*l + x)) * tan(tau*abs((n-1)*l-x))) / (tan(tau*abs(n*l - x)) * tan(tau*((n-1)*l+x)))) - log((tan(tau*((n+1)*l + x)) * tan(tau*abs((n)*l-x))) / (tan(tau*abs((n+1)*l - x)) * tan(tau*((n)*l+x)))));
matInt2 = @(x, n) 1/(pi*l) * log((tan(tau*(n*l + x)) * tan(tau*abs((n-1)*l-x))) / (tan(tau*abs(n*l - x)) * tan(tau*((n-1)*l+x))));

% Gauss-Jacobi points weights
[xj1, wj1] = GaussJacobi(6,0,0.5);
[xj2, wj2] = GaussJacobi(6,0.5,0);

% Integration from 0 to l
sum11 = 0;
sum12 = 0;
sum21 = 0;
sum22 = 0;

for i=1:length(xj1)
   sum11 = sum11 + wj1(i) * phi11(l/2*(xj1(i)+1)) * matInt1(l/2*(xj1(i)+1), 1) * (1-xj1(i))^(-0.5);
   sum12 = sum12 + wj1(i) * phi11(l/2*(xj1(i)+1)) * matInt2(l/2*(xj1(i)+1), 2) * (1-xj1(i))^(-0.5);
   sum21 = sum21 + wj1(i) * phi21(l/2*(xj1(i)+1)) * matInt1(l/2*(xj1(i)+1), 1) * (1-xj1(i))^(-0.5);
   sum22 = sum22 + wj1(i) * phi21(l/2*(xj1(i)+1)) * matInt2(l/2*(xj1(i)+1), 2) * (1-xj1(i))^(-0.5);
end

% Integration from l to 2l

for i=1:length(xj1)
    sum11 = sum11 + wj2(i) * phi12(l/2*(xj2(i)+3)) * matInt1(l/2*(xj2(i)+3), 1) * (1+xj2(i))^(-0.5);
    sum12 = sum12 + wj2(i) * phi12(l/2*(xj2(i)+3)) * matInt2(l/2*(xj2(i)+3), 2) * (1+xj2(i))^(-0.5);
    sum21 = sum21 + wj1(i) * phi22(l/2*(xj1(i)+3)) * matInt1(l/2*(xj1(i)+3), 1) * (1-xj1(i))^(-0.5);
    sum22 = sum22 + wj1(i) * phi22(l/2*(xj1(i)+3)) * matInt2(l/2*(xj1(i)+3), 2) * (1-xj1(i))^(-0.5);
end

sum11 = sum11 * (1 / (2*pi*l));
sum12 = sum12 * (1 / (2*pi*l));
sum21 = sum21 * (1 / (2*pi*l));
sum22 = sum22 * (1 / (2*pi*l));
