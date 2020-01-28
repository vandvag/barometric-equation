%===============================================================================
% Utility for visualizing the shape functions and the matrix integrands
%===============================================================================

clear all
close all
clc

% Check if out directory exists
if ~exist('out', 'dir')
    mkdir('out')
end

% Store results prompt
storeResFlag = input('Do you want to store the results?(y/n) ', 's');

% Define element parameters
n = 5;
a = 1;
l = a / n;
tau = pi / (4*a);
c = 1;
p0 = 1;
alpha=-0.5;

% Discretization
num_points = 300;
x = linspace(0,a,num_points);
y = linspace(0,a,num_points);

% Get shape functions at each point
phis = shapeFunctions(n, a, x)';
matInt = matrixIntegrands(n, a, x)';
phi_data = x';
phi_legend = [];
matInt_data = x';
matInt_legend = [];

figure()
for i=1:n
    hold on
    subplot(1,2,1)
    plot(x, phis(:,i), 'DisplayName', ['\phi_{', num2str(i), '}'])
    hold on
    subplot(1,2,2)
    plot(x, matInt(:,i), 'DisplayName', ['[(A^*A)^{1/2}\phi_{e', num2str(i),'}]'])

    phi_data = [phi_data, phis(:, i)];
    matInt_data = [matInt_data, matInt(:, i)];
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


% Plot \Phi_km =\phi_k matInt_m
figure()
hold on

% for i=1:1
%     for j=1:1
%         % if j~=i
%         plot(x', phis(:, i) .* matInt(:, j), 'DisplayName', 'original');
%         plot(x', phis(:, i) .* matInt(:, j) .* abs(x' - i*l), 'DisplayName', 'smoothed')
%         % end
%     end
% end

i=1;
j=1;
smoothed_M = [x', phis(:, i) .* matInt(:, j), phis(:, i) .* matInt(:, j) .* abs(x' - i*l).^(-alpha)];
plot(smoothed_M(:,1), smoothed_M(:,2), 'DisplayName', 'original');
plot(smoothed_M(:,1)', smoothed_M(:,3), 'DisplayName', 'smoothed');
title(['Matrix integrand \varphi_', num2str(i), '[(A^*A){1/2}\varphi_', num2str(j),']'])
xlabel('l/a')
grid on
legend

% % PLOT G1/2
% G_12 = zeros(num_points, num_points);
% for i=1:num_points
%     for j=1:num_points
%         G_12(i, j) = G12(x(i), y(j), a);
%     end
% end

% figure()
% surf(x,y,G_12)

if storeResFlag == 'y' || storeResFlag == 'Y'
    writematrix(phi_data, 'out/phi_out.dat', 'Delimiter', 'tab');
    writematrix(matInt_data,'out/matInt_out.dat', 'Delimiter', 'tab');
    writematrix(smoothed_M, 'out/smoothed_M.dat', 'Delimiter', 'tab');
end
disp('Process ended!')