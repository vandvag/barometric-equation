# Solution of barometric equation

The MATLAB code provided in this repository tries to solve the barometric pressure differential equation

## Important!

The current working directory (```pwd``` in MATLAB) should be the same as the one that ```main.m``` is in (root directory of the project)
## Input

The input of the problem is given via the ```input.txt``` file. Change the values there.

## Main function
The main function ```main.m``` calls the methods found in the ```src``` folder.

## ```src```

- ```readInput.m``` : Reads the ```input.txt``` file and outputs the values of the variables stored in it
- ```analyticalSolution.m```: Provides the pressure at each discretization point by evaluating the analytical solution of the problem
- ```forwardDiff.m```: Provides the solution at each point via the forward difference method
- ```backwardDiff.m```: Proved the solution at each point via the backwards difference method
- ```FEM```: Provides the solution at each point via the Finite Element Method. This method contains:
  - ```FEM.m```: Main FEM routine
  - ```assembler.m```: Constructs the FE system matrix
  - ```boundaryConditions.m```: Imposes the boundary conditions on the system matrix and the right-hand side of the equation
- ```fractional```: Provides the solution at each point utilizing the fractional calculus formulation. This method contains:
  - ```fractional.m```: Main fractional calculus formulation method
  - ```LHSFrac.m```: Calculates the left-hand side of the equation
  - ```RHSFrac.m```: Calculates the right-hand side of the equation

## ```utils```

- ```G12.m```: Evaluates the fractional derivative ```G_(1/2)``` at points x and y
- ```matInts.m```: Evaluates the matrix integrands M as defined in the report
- ```shapeFncs.m```: Evaluates the k-th shape function at a point x, as they are defined in the report.
- ```mesher.m```: Utility for providing a discretization of the domain
- ```visualization```: Utility for providing plots of the shape functions and the matrix integrands, as defined in the report. Main method is the ```visualization.m```
- ```gauss```: Provides the nodes and weights for the Gauss-Jacobi integration scheme. Main method is the ```gaussInt.m```
- ```plot_res.m```: Provides plots of the solution for the selected methods
- ```find_error.m```: Calculates the relative error of each method compared to the analytical solution
- ```plot_errros.m```: Provides plots for the relative error for each method