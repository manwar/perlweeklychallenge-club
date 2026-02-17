
## Ref.:
## https://www.geeksforgeeks.org/python/python-program-for-zeckendorfs-theorem-non-neighbouring-fibonacci-representation/

from itertools import chain, combinations
from math import ceil

def GetPowIndxSet (arrIterable):
    arrList = list(arrIterable)
    arrFinalList = chain.from_iterable(combinations(range(len(arrIterable)), nIndxLoop) for nIndxLoop in range(len(arrList) + 1))
    return arrFinalList

def CheckConsecutiveIndx (arrIterable):
    for nIndx, nElem in enumerate (arrIterable):
        if nIndx == 0:
            continue

        if nElem - arrIterable[nIndx - 1] == 1:
            return False

    return True

## nInt = 4  ## Example 1
## nInt = 12  ## Example 2
## nInt = 20  ## Example 3
## nInt = 96  ## Example 4
nInt = 100  ## Example 5

arrFibSeq = [1, 2, 3, 5, 8, 13, 21, 34, 55, 89]

arrResult = []
for arrLoop in GetPowIndxSet(arrFibSeq):
    arrFinal = list(arrLoop)

    if len(arrFinal) == 0:
        continue

    if len(arrFinal) > ceil(len(arrFibSeq) / 2):
        continue

    if not CheckConsecutiveIndx (arrFinal):
        continue

    arrTemp = [arrFibSeq[nElemLoop] for nElemLoop in arrFinal]

    if sum(arrTemp) != nInt:
        continue

    arrResult.append(arrTemp)

print (arrResult)
