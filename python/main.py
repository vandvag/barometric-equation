import yaml
import input_output as io
from mesher import Mesher

# 1. Read input
input_filename = "input.yml"
data = io.readInputFile(input_filename, True)

# 2. Discretize the domain
mesherTool = Mesher(data)
nodalCoords = mesherTool.get_mesh()
location = mesherTool.get_location_matrix()
print(nodalCoords)
print(location)

# 3. Analytical pressure
