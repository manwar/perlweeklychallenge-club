
from itertools import permutations

def GenSecretSanta(nInput):
    if nInput < 2:
        return 0

    arrElem = [nIndx for nIndx in range(nInput)]
    arrOutput = []
    for arrLoop in permutations(arrElem):
        arrTemp = [arrLoop.index(nElem) == nElem for nElem in arrLoop]
        if any(arrTemp):
            continue
        arrOutput.append(arrLoop)

    return len(arrOutput)

## nInt = 1  ## Example 1
## nInt = 2  ## Example 2
## nInt = 3  ## Example 3
## nInt = 4  ## Example 4
nInt = 5  ## Example 5

print (GenSecretSanta(nInt))
