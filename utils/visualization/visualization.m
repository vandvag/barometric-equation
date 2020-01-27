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

% Discretization
x = linspace(0,a,300);

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

% Store data
if storeResFlag == 'y' || storeResFlag == 'Y'
    writematrix(phi_data, 'out/phi_out.dat', 'Delimiter', 'tab');
    writematrix(matInt_data,'out/matInt_out.dat', 'Delimiter', 'tab');
end
disp('Process ended!')

% 
% figure(2)
% hold on
% 
% for i=1:n
%     for j=1:size(matInt,1)
%         % if j~=i
%         plot(x, phis(i,:) .* matInt(j, :), 'DisplayName', ['\phi_{', num2str(i), '}', '[(A^*A)^{1/2}\phi_{e', num2str(j),'}]'])
%         % end
%     end
% end
% title('Intergrands')
% xlabel('x')
% grid on
% legend
