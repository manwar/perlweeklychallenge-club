
from statistics import mean

## arrInput = [1, 2, 4, 5, 6]  ## Example 1
## arrInput = [-5, -2, -1, 3]  ## Example 2
## arrInput = [1, 2, 3]  ## Example 3
## arrInput = [2, 3, 7, 8]  ## Example 4
arrInput = [1, 1, 1, 10]  ## Example 5

nMax = max(arrInput)
dMean = mean(arrInput)

nOutput = min([nElem for nElem in range(max(int(dMean), 0) + 1, max(nMax, 0) + 2) if nElem not in arrInput])

print (nOutput)
