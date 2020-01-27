function plot_res(nodalCoords,...
                  pressureAnalytical, ...
                  pressureForward, ...
                  pressureBackward, ...
                  pressureFEM, ...
                  pressureFrac, ...
                  resultsToPlot)
 
                  
figure()
title('Solution of Barometric Equation')
xlabel('Altitude h (m)')
ylabel('Pressure P (bar)')

hold on
for i=1:length(resultsToPlot)
    switch(resultsToPlot(i))
        case 1
            plot(nodalCoords, pressureAnalytical, 'DisplayName', 'Analytical Solution')
        case 2
            plot(nodalCoords, pressureForward, 'DisplayName', 'Forward Differences')
        case 3
            plot(nodalCoords, pressureBackward, 'DisplayName', 'Backward Differences')
        case 4
            plot(nodalCoords, pressureFEM,'--', 'DisplayName', 'FEM')
        case 5
            plot(nodalCoords, pressureFrac, 'DisplayName', 'Fractional')
    end
end


legend show
grid on

end
