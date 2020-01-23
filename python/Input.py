class Input:

    def __init__(self):
        # self.filename = input("Give name of input file: ")
        self.filename = "input.txt"

    def getInput(self):
        params = {}
        with open(self.filename, "r") as f:
            for line in f.readlines():
                if line[0] == "%":
                    continue
            
                temp = [s.strip() for s in line.split("=")]
                if len(temp) > 1:
                    params[temp[0]] = temp[1]


        return params