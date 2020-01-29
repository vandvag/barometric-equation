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
xlabel('l/a')
grid on
legend

% % PLOT G1/2
x = linspace(0,a,50)';
y = linspace(0,a,50)';
G12_points = zeros(50*50, 3);
counter = 0;
for i=1:50
    for j=1:50
        counter = counter + 1;
        G_12 = G12(x(i), y(j), a);
        G12_points(counter, :) = [x(i), y(j), G_12];
    end
end

%% Plot G_tilde

x = linspace(0,a,300)';
G_tilde = zeros(300,1);
G_tilde_smooth = zeros(300,1);

for i=1:300
    G_tilde(i) = - phis(i, 1) * G12(x(i), x(i)/10, a) * p0*c^2/(1+c*a)*exp(c*x(i)/10)*(1+c*(x(i)/10-a));
    G_tilde_smooth(i) = - phis(i, 1) * G12(x(i), x(i)/10, a) * p0*c^2/(1+c*a)*exp(c*x(i)/10)*(1+c*(x(i)/10-a))*(9*x(i)/10)^(-alpha);
end

figure()
plot(x, G_tilde)
hold on 
plot(x, G_tilde_smooth)
hold off

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
    writematrix(G12_points, 'G12_points.dat', 'Delimiter', 'tab');
end
disp('Process ended!')