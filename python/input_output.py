import yaml
import os


def readInputFile(filename, verbose=False):
    with open(filename, "r") as f:
        data = yaml.load(f)

    if verbose:
        print("Data read successfully!")
    return data


def storeInputFile(params, output_filename=None):
    if output_filename == None:
        output_filename = str(input("Please give filename:\n"))
    else:
        output_filename = checkFileExistence(output_filename)

    with open(output_filename, "w") as f:
        yaml.dump(params, f, default_flow_style=False)

def checkFileExistence(_filename):
    current_dir = os.getcwd()

    if os.path.exists(_filename):
        temp = input("File exists! Do you want to overwrite? (y/n)\n")

        if temp.lower() == "y":
            return _filename

    else:
        return _filename

    counter = 0

    while True:
        if os.path.exists(_filename):
            counter += 1
            _filename = _filename[:-4] + f"{counter}" + _filename[-4:]
        else:
            return _filename