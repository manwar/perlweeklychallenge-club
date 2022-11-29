
from itertools import product

## nInput = 2  ## Example 1
nInput = 3  ## Example 2

arrStrOutput = []

for arrIndx in product(range(2), repeat = nInput):
    arrStrOutput.append("".join([str(nIndx) for nIndx in arrIndx]))

print (arrStrOutput)
