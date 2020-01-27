%===============================================================================
% Utility for visualizing the shape functions and the matrix integrands
%===============================================================================

clear all
close all
clc

pwd
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

figure(1)
for i=1:1
    hold on
    subplot(1,2,1)
    plot(x, phis(:,i), 'DisplayName', ['\phi_{', num2str(i), '}'])
    hold on
    subplot(1,2,2)
    plot(x, matInt(:,i), 'DisplayName', ['[(A^*A)^{1/2}\phi_{e', num2str(i),'}]'])
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

% Output data
phi_data = [x', phis(:, 1)];
matInt_data = [x', matInt(:, 1)];

dlmwrite('phi_out.csv', phi_data, 'delimiter', '\t');
dlmwrite('matInt_out.csv', matInt_data, 'delimiter', '\t');

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
