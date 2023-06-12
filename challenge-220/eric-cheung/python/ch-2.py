
from itertools import permutations
from math import sqrt

def IsPerfectSqr (nInput):
    dSqRoot = int(sqrt(nInput))
    return (dSqRoot * dSqRoot == nInput)

arrIntList = [1, 17, 8]  ## Example 1
## arrIntList = [2, 2, 2]  ## Example 2

arrOutputList = []

arrPerm = set(permutations(arrIntList))

for permLoop in list(arrPerm):
    bIsSqrFul = True
    for nIndx in range(0, len(permLoop) - 1):
        if not IsPerfectSqr(permLoop[nIndx] + permLoop[nIndx + 1]):
            bIsSqrFul = False
            break

    if bIsSqrFul and not permLoop in arrOutputList:
        arrOutputList.append(permLoop)

print (arrOutputList)
