
from itertools import permutations

def IsBeautiful (arrInput):
    for nIndx, nLoop in enumerate(arrInput):
        if (nLoop + 1) % (nIndx + 1) == 0:
            continue

        if (nIndx + 1) % (nLoop + 1) == 0:
            continue

        return False

    return True

## nInt = 2  ## Example 1
## nInt = 1  ## Example 2
nInt = 10  ## Example 3

objPermList = permutations(range(nInt))

arrOutput = [1 if IsBeautiful(arrListLoop) else 0 for arrListLoop in list(objPermList)]

print (sum(arrOutput))
