
from itertools import combinations

## arrInts = [4, 2, 1, 3]  ## Example 1
## arrInts = [10, 100, 20, 30]  ## Example 2
## arrInts = [-5, -2, 0, 3]  ## Example 3
## arrInts = [8, 1, 15, 3]  ## Example 4
arrInts = [12, 5, 9, 1, 15]  ## Example 5

arrInts = sorted(list(set(arrInts)))

objCombList = combinations(arrInts, 2)

arrMinAbsDiffList = []
bForceSetDiff = True
nMinAbsDiff = 0

for arrCombLoop in objCombList:
    nAbsDiff = arrCombLoop[1] - arrCombLoop[0]
    if not bForceSetDiff and nAbsDiff > nMinAbsDiff:
        continue

    if bForceSetDiff:
        nMinAbsDiff = nAbsDiff
        bForceSetDiff = False

    if nAbsDiff < nMinAbsDiff:
        nMinAbsDiff = nAbsDiff
        arrMinAbsDiffList = []

    arrMinAbsDiffList.append(list(arrCombLoop))

print (arrMinAbsDiffList)
