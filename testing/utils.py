import numpy as np
from numpy import pi, tan, log, abs


def shape_functions(n, a, x):
    """
    Evaluates the shape functions at given points
    int n: Number of elements
    float a: Domain length
    ndarray x: Points in which shape functions will be evaluated
    returns: Vector of each function evaluated at each point
    """

    # Define element length
    l = a / n

    # Initialize shape functions
    shape_funcs = np.zeros((n, x.shape[0]))

    for k in range(n):
        for i in range(x.shape[0]):
            if k * l <= x[i] < (k + 1) * l:
                shape_funcs[k, i] = x[i] / l - k
            elif (k + 1) * l <= x[i] <= (k + 2) * l:
                shape_funcs[k, i] = (k + 2) - x[i] / l

    return shape_funcs


def matrix_integrands(n, a, x):
    """
    Evaluates the matrix integrands at given points
    int n: Number of elements
    float a: Domain length
    ndarray x: Points in which shape functions will be evaluated
    returns: Vector of each matrix integrand evaluated at each point
    """

    # Define element length
    l = a / n
    # Define constant tau
    tau = pi / (4 * a)

    # Initialize array
    mat_ints = np.zeros((n, x.shape[0]))

    for m in range(n):
        print(m)
        if m == n - 1:
            mat_ints[m, :] = 1 / (pi * l) * log((tan(tau * (n * l + x)) * tan(tau * abs((n - 1) * l - x))) / (
                    tan(tau * abs(n * l - x)) * tan(tau * ((n - 1) * l + x))))
        else:
            mat_ints[m, :] = 1 / (pi * l) * (log((tan(tau * ((m + 1) * l + x)) * tan(tau * abs(m * l - x))) / (
                    tan(tau * abs((m + 1) * l - x)) * tan(tau * (m * l + x)))) - log(
                (tan(tau * ((m + 2) * l + x)) * tan(tau * abs((m + 1) * l - x))) / (
                        tan(tau * abs((m + 2) * l - x)) * tan(tau * ((m + 1) * l + x)))))

    return mat_ints
