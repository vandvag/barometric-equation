function matInt = matrixIntegrands(n,a,x)
% Evaluates the matrix integrands at specific positions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUT:
% n: Number of elements
% a: Length of the domain
% x: Vector containing the points at which the shape functions will be evaluated
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% OUPUT
% matInt: Array containing the value of each matrix integrand at each point x
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

l = a / n;
matInt = zeros(n, length(x));
tau = pi/(4*a);

for m=1:n
    for i=1:length(x)
        if m==n
            matInt(m,i) = 1/(pi*l) * log((tan(tau*(m*l + x(i))) * tan(tau*abs((m-1)*l-x(i)))) / (tan(tau*abs(m*l - x(i))) * tan(tau*((m-1)*l+x(i)))));
        else
            matInt(m,i) = 1/(pi*l) * (log((tan(tau*(m*l + x(i))) * tan(tau*abs((m-1)*l-x(i)))) / (tan(tau*abs(m*l - x(i))) * tan(tau*((m-1)*l+x(i))))) - log((tan(tau*((m+1)*l + x(i))) * tan(tau*abs((m)*l-x(i)))) / (tan(tau*abs((m+1)*l - x(i))) * tan(tau*((m)*l+x(i))))));
        end
    end
end

end

