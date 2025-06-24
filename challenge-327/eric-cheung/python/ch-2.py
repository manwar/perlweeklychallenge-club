
from itertools import combinations

## arrInts = [4, 1, 2, 3]  ## Example 1
## arrInts = [1, 3, 7, 11, 15]  ## Example 2
arrInts = [1, 5, 3, 8]  ## Example 3

arrCombList = combinations(arrInts, 2)

arrOutput = []
nMinAbsDiff = max(arrInts) - min(arrInts)

for arrLoop in arrCombList:
    nAbsDiff = abs(arrLoop[0] - arrLoop[1])

    if nAbsDiff > nMinAbsDiff:
        continue

    if nAbsDiff < nMinAbsDiff:
        nMinAbsDiff = nAbsDiff
        arrOutput = []

    arrOutput.append(sorted(list(arrLoop)))

print (sorted(arrOutput))
