function plot_errors(nodalCoords, pressureAnalytical, pressureForward,...
                     pressureBackward, pressureFEM, pressureFrac)
                 
figure()

errForward = abs((pressureForward - pressureAnalytical) ./ pressureAnalytical);
errBackward = abs((pressureBackward - pressureAnalytical) ./ pressureAnalytical);
errFEM = abs((pressureFEM - pressureAnalytical) ./ pressureAnalytical);
errFrac = abs((pressureFrac - pressureAnalytical) ./ pressureAnalytical);

hold on
plot(nodalCoords, errForward, 'DisplayName', 'Error Forward')
plot(nodalCoords, errBackward, 'DisplayName', 'Error Backward')
plot(nodalCoords, errFEM, 'DisplayName', 'Error FEM')
plot(nodalCoords, errFrac, 'DisplayName', 'Error Fractional')

legend show
grid on
end
