
from math import sqrt

## nInt = 20  ## Example 1
## nInt = 7  ## Example 2
## nInt = 1  ## Example 3
## nInt = 15  ## Example 4
nInt = 30  ## Example 5

nSqrt = int(sqrt(nInt))

arrOutput = []
for nA in range(1, nInt):
    for nB in range(nA, nInt):
        dC = sqrt(nA ** 2 + nB ** 2)
        if not dC.is_integer() or dC > nInt:
            continue

        nC = int(dC)
        arrOutput.append([nA, nB, nC])
        arrOutput.append([nB, nA, nC])

print (len(arrOutput))
