clear all

c  = 1;
p0 = 1;
n  = 2;
a  = 2;
l  = a / n;
tau = pi / (4*a);

%% Gauss-Jacobi points weights
numGaussPoints = 10;
%alpha= 0.5, beta =0
[xj1, wj1] = GaussJacobi(numGaussPoints,0,0.5);
%alpha=0, beta=0.5
[xj2, wj2] = GaussJacobi(numGaussPoints,0.5,0);

%% Definition of M matrix

M = zeros(n,n);

xis1 = zeros(length(xj1),1);
xis2 = zeros(length(xj1),1);

% TODO add gauss weights
% TODO differentiate between xj1, xj2
%% Integration from 0 to l
weight = (l-0) / 2;
% Calculate the Gauss Point Coordinates
for i=1:length(xj1)
  xis1(i) = coordChange(0,l,xj1(i));
  xis2(i) = coordChange(0,l,xj2(i));
end
% Evaluate the matrix integrands at the the Gauss points
matInts = matrixIntegrands(n,a,xis1);
shapeFncs = shapeFunctions(n,a,xis1);
for i=1:n
  for j=1:n
    M(i,j) = M(i,j) + sum(shapeFncs(i,:) .* matInts(j,:));
  end
end

%% Integration from l to a
weight = (l-0) / 2;
                                % Calculate the Gauss Point Coordinates
for i=1:length(xj1)
  xis1(i) = coordChange(l,a,xj1(i));
  xis2(i) = coordChange(l,a,xj2(i));
end
                        % Evaluate the matrix integrands at the the Gauss points
matInts = matrixIntegrands(n,a,xis1);
shapeFncs = shapeFunctions(n,a,xis1);
for i=1:n
  for j=1:n
    M(i,j) = M(i,j) + sum(shapeFncs(i,:) .* matInts(j,:));
  end
end
