
from itertools import permutations

## arrList = [1, 23]  ## Example 1
## arrList = [10, 3, 2]  ## Example 2
## arrList = [31, 2, 4, 10]  ## Example 3
## arrList = [5, 11, 4, 1, 2]  ## Example 4
arrList = [1, 10]  ## Example 5

arrPerm = permutations(arrList)

nMax = 0

for arrLoop in arrPerm:
    strTempNum = "".join([str(nElemLoop) for nElemLoop in arrLoop])
    if int(strTempNum) > nMax:
        nMax = int(strTempNum)

print (nMax)
