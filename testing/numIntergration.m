clear

c = 1;
p0=1;
n = 2;
a = 2;
l = a / n;
tau = pi / (4*a);

%% SYSTEM MATRIX M
% Define the functions
phi11 = @(x) x / l;
phi12 = @(x) 2 - x/l;
phi21 = @(x) 0;
phi22 = @(x) x / l - 1;

matInt1 = @(x) (log((tan(tau*(1*l + x)) * tan(tau*abs((1-1)*l-x))) / (tan(tau*abs(1*l - x)) * tan(tau*((1-1)*l+x)))) - log((tan(tau*((1+1)*l + x)) * tan(tau*abs((1)*l-x))) / (tan(tau*abs((1+1)*l - x)) * tan(tau*((1)*l+x)))));
% matInt1 = @(x, m) log((tan(tau*(m*l+x)) * tan(tau*abs((m-1)*l+x))) / (tan(tau*abs(m*l-x)) * tan(tau*((m-1)*l+x)))) - log((tan(tau*((m+1)*l+x)) * tan(tau*abs(m*l-x))) / (tan(tau*abs((m+1)*l-x)) * tan(tau*(m*l+x))));
matInt2 = @(x)  log((tan(tau*(2*l + x)) * tan(tau*abs((2-1)*l-x))) / (tan(tau*abs(2*l - x)) * tan(tau*((2-1)*l+x))));
% matInt2 = @(x,n) log((tan(tau*(n*l+x)) * tan(tau*abs((n-1)*l-x))) / (tan(tau*abs(n*l-x)) * tan(tau*abs((n-1)*l-x))));
G = @(x,y) log(tan(tau*(x+y)) / tan(tau*abs(x-y))) * exp(c*y);

% Gauss-Jacobi points weights
%alpha= 0.5, beta =0
[xj1, wj1] = GaussJacobi(10,0,0.5);
%alpha=0, beta=0.5
[xj2, wj2] = GaussJacobi(10,0.5,0);

% Integration from 0 to l
sum11 = 0;
sum12 = 0;
sum21 = 0;
sum22 = 0;

for i=1:length(xj1)
   xi = coordChange(0, l, xj1(i));
   sum11 = sum11 + wj1(i) * phi11(xi) * matInt1(xi) * (1-xj1(i))^(-0.5);
   sum12 = sum12 + wj1(i) * phi11(xi) * matInt2(xi) * (1-xj1(i))^(-0.5);
   sum21 = sum21 + wj1(i) * phi21(xi) * matInt1(xi) * (1-xj1(i))^(-0.5);
   sum22 = sum22 + wj1(i) * phi21(xi) * matInt2(xi) * (1-xj1(i))^(-0.5);
end

% Integration from l to 2l

for i=1:length(xj1)
    xi = coordChange(l, a, xj1(i));
    sum11 = sum11 + wj2(i) * phi12(xi) * matInt1(xi) * (1+xj2(i))^(-0.5);
    sum12 = sum12 + wj2(i) * phi12(xi) * matInt2(xi) * (1+xj2(i))^(-0.5);
    sum21 = sum21 + wj1(i) * phi22(xi) * matInt1(xi) * (1-xj1(i))^(-0.5);
    sum22 = sum22 + wj1(i) * phi22(xi) * matInt2(xi) * (1-xj1(i))^(-0.5);
end

sum11 = sum11 / (2*pi);
sum12 = sum12 / (2*pi);
sum21 = sum21 / (2*pi);
sum22 = sum22 / (2*pi);

M = [sum11, sum12; sum21, sum22];


