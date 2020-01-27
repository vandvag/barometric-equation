function plot_errors(nodalCoords, ...
                     errForward, ... 
                     errBackward,...
                     errFEM, ...
                     errFrac)
% Plots the relative error at each node
%==========================================================================
% INPUT
%   nodalCoords: Coordinates of spatial nodes
%   errForward: Relative error at each node (forward difference method)
%   errBackward: Relative Error at each node (backward difference method)
%   errFEM: Relative error at each node (FEM difference method)
%   errFrac: Relative error at each node (fractional derivation)
%   logFlag: Choose between semilogy plot or linear plot (boolean)
%==========================================================================
% OUTPUT
%==========================================================================        
figure()
logFlag = true;

if logFlag
    semilogy(nodalCoords, errForward, 'DisplayName', 'Error Forward')
    hold on
    semilogy(nodalCoords, errBackward, 'DisplayName', 'Error Backward')
    semilogy(nodalCoords, errFEM, 'DisplayName', 'Error FEM')
    semilogy(nodalCoords, errFrac, 'DisplayName', 'Error Fractional')
    hold off
else
    plot(nodalCoords, errForward, 'DisplayName', 'Error Forward')
    hold on
    plot(nodalCoords, errBackward, 'DisplayName', 'Error Backward')
    plot(nodalCoords, errFEM, 'DisplayName', 'Error FEM')
    plot(nodalCoords, errFrac, 'DisplayName', 'Error Fractional')
    hold off
end


title('Absolute error between methods')
xlabel('Altitude (m)')
ylabel('log(error)(-)')
legend show
grid on
end
