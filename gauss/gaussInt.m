function [nodesGauss, weightsGauss] = gaussInt(numGaussPoints, alpha, beta)
% Calculates the nodes and the weights of the Gauss Jacobi
% quadrature
% INPUT:
% numGaussPoints: number of Gauss Points (nodes)
% alpha: alpha parameter
% beta: beta parameter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% OUTPUT:
% nodesGauss: nodes of Gauss-Jacobi quadrature
% weightsGauss: weights of Gauss-Jacobi quadrature
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
r = r_jacobi(numGaussPoints, alpha, beta); % Recurence coefficients due to Gautschi
zw = gauss(numGaussPoints, r); % Jacobi nodes and weights
nodesGauss = zw(:, 1); % Nodes
weightsGauss = zw(:,2); % Weights
end
