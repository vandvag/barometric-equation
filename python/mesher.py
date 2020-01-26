import numpy as np


class Mesher:

    def __init__(self, params):
        self.params = params

    def get_mesh(self):
        domain_length = self.params["MAX_ALT"] - self.params["INIT_ALT"]
        element_length = self.params["ND_SPACING"]
        num_elements = int(domain_length / element_length)
        num_nodes = num_elements + 1

        nodal_coords = np.zeros(num_nodes)

        for nd in range(num_nodes):
            nodal_coords[nd] = nd * element_length

        return nodal_coords

    def get_location_matrix(self):
        domain_length = self.params["MAX_ALT"] - self.params["INIT_ALT"]
        element_length = self.params["ND_SPACING"]
        num_elements = int(domain_length / element_length)
        num_nodes = num_elements + 1

        location_matrix = np.zeros((2, num_elements))

        for el in range(num_elements):
            location_matrix[0, el] = el
            location_matrix[1, el] = el + 1
        
        return location_matrix.astype('int32')
