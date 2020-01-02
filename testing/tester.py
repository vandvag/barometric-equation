import matplotlib.pyplot as plt
import numpy as np
from numpy import pi
from testing.utils import shape_functions, matrix_integrands


c = 1
p0 = 1
n = 5
a = 5
l = a / n
tau = pi / (4 * a)

discr = np.linspace(0, a, 1000)
shape_funcs = shape_functions(n, a, discr)

mat_ints = matrix_integrands(n, a, discr)
# Plots 

for i in range(n):
    plt.plot(discr, shape_funcs[i, :], label="{}".format(i + 1))
plt.legend()
plt.show()
plt.figure(1)
for i in range(n):
    plt.plot(discr, mat_ints[i, :], label="{}".format(i + 1))
plt.legend()
plt.show()
plt.figure(2)
plt.plot(discr, mat_ints[-1, :], label="{}".format(4 + 1))
plt.show()
