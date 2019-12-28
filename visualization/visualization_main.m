clear all
close all
clc

% Define element parameters
n = 2;
a = n;
l = a / n;
tau = pi / (4*a);
c = 1;
p0 = 1;

% Discretization
x = linspace(0,a,100);

% Get shape functions at each point
phis = shapeFunctions(n, a, x);
matInt = matrixIntegrands(n, a, x);

figure(1)
for i=1:size(phis,1)
    hold on
    subplot(1,2,1)
    plot(x, phis(i,:), 'DisplayName', ['\phi_{', num2str(i), '}'])
    hold on
    subplot(1,2,2)
    plot(x, matInt(i,:), 'DisplayName', ['[(A^*A)^{1/2}\phi_{e', num2str(i),'}]'])
end
subplot(1,2,1)
title('Shape Functions')
xlabel('x')
ylabel('\phi')
hold off
legend

subplot(1,2,2)
title('[(A^*A)^{1/2}\phi_{e_i}]_{i=1,2}')
xlabel('x')
hold off
legend

figure(2)
hold on

for i=1:size(phis,1)
    for j=1:size(matInt,1)
        if j~=i
        plot(x, phis(i,:) .* matInt(j, :), 'DisplayName', ['\phi_{', num2str(i), '}', '[(A^*A)^{1/2}\phi_{e', num2str(j),'}]'])
        end
    end
end
title('Intergrands')
xlabel('x')
grid on
legend

%% Visualize G_{1/2}
G = @(x,y) (x/l) * log(tan(tau*(x+y)) / tan(tau*abs(x-y))) *exp(c*y);
G12_plot = zeros(length(x), 1);

figure(3)
for i=1:length(x)
    G12_plot(i) = G(a/6, x(i));
end

plot(x, G12_plot)

title('RHS')
