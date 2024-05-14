
from itertools import combinations

def GetBitWiseOR (arrInput):

    nResult = 0
    for rLoop in arrInput:
        nResult = nResult | rLoop
    return nResult

## arrInt = [1, 2, 3, 4, 5]  ## Example 1
## arrInt = [2, 3, 8, 16]  ## Example 2
arrInt = [1, 2, 5, 7, 9]  ## Example 3

bIsEven = False

for nLoop in range(2, len(arrInt) + 1):

    arrCombList = combinations(arrInt, nLoop)

    for arrLoop in list(arrCombList):
        if GetBitWiseOR (arrLoop) % 2 == 0:
            bIsEven = True
            break

    if bIsEven:
        break

print (bIsEven)
