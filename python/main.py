import yaml
import input_output as io

# 1. Read input
input_filename = "input.yml"

data = io.readInputFile(input_filename, True)

io.storeInputFile(data, "output.yml")