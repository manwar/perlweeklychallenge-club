
from itertools import combinations

def IsDoubleExist (arrInput):
    return arrInput[0] == 2 * arrInput[1]

## arrInts = [6, 2, 3, 3]  ## Example 1
## arrInts = [3, 1, 4, 13]  ## Example 2
arrInts = [2, 1, 4, 2]  ## Example 3

arrCombList = combinations(arrInts, 2)

bFlag = False
for arrLoop in list(arrCombList):
    if IsDoubleExist (arrLoop):
        bFlag = True
        break

print (bFlag)
