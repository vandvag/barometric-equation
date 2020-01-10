clear all

n  = 100;
c  = 1;
p0 = 1;
a  = n;
l  = a / n;
tau = pi / (4*a);

%% Gauss-Jacobi points weights
numGP = 30;

%alpha= 0.5, beta =0
[xj1, wj1] = gaussInt(numGP, 0.5, 0);
%alpha=0, beta=0.5
[xj2, wj2] = gaussInt(numGP, 0, 0.5);

%% Definition of M matrix

M = zeros(n,n);

xis1 = zeros(length(xj1),1);
xis2 = zeros(length(xj1),1);

for elem=1:(n-1)
    %% Integration from (n-1) * l to n * l
    % weight introduced due to coordinate change
    weightCoord = (elem * l - (elem-1) * l) / 2;
    % Calculate the Gauss Point Coordinates
    for i=1:length(xj1)
      xis1(i) = coordChange((elem-1)*l,elem*l,xj1(i));
      xis2(i) = coordChange((elem-1)*l,elem*l,xj2(i));
    end
    % Evaluate the matrix integrands at the the Gauss points
    matInts = matrixIntegrands(n,a,xis1);
    shapeFncs = shapeFunctions(n,a,xis1);
    for i=1:n
      for j=i:n
        for k=1:numGP
          M(i,j) = M(i,j) + shapeFncs(i,k) * matInts(j, k) * (1-xj1(k))^(-0.5) * weightCoord * wj1(k);
        end
      end
    end

    %% Integration from l to a
    weightCoord = ((elem+1)*l - elem*l) / 2;
    % Calculate the Gauss Point Coordinates
    for i=1:length(xj1)
      xis1(i) = coordChange(elem*l,(elem+1)*l,xj1(i));
      xis2(i) = coordChange(elem*l,(elem+1)*l,xj2(i));
    end
    % Evaluate the matrix integrands at the the Gauss points
    matInts = matrixIntegrands(n,a,xis1);
    shapeFncs = shapeFunctions(n,a,xis1);
    for i=1:n
      for j=i:n
        for k=1:numGP
          M(i,j) = M(i,j) + shapeFncs(i,k) * matInts(j, k) * (1-xj1(k))^(-0.5) * weightCoord * wj1(k);
        end
      end
    end
end

% Make M symmetric
for i=1:n
    for j=1:n
        M(j,i) = M(i,j);
    end
end


M
