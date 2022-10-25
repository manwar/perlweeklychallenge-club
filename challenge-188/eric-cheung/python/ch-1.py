
from itertools import combinations

## Example 1
## arrInputList = [4, 5, 1, 6]
## n_K = 2

## Example 2
## arrInputList = [1, 2, 3, 4]
## n_K = 2

## Example 3
## arrInputList = [1, 3, 4, 5]
## n_K = 3

## Example 4
## arrInputList = [5, 1, 2, 3]
## n_K = 4

## Example 5
arrInputList = [7, 2, 4, 5]
n_K = 4


def IsSatisfyRule(arrInput):

    n_I = arrInput[0]
    n_J = arrInput[1]

    if not (n_I >= 0 and n_I < n_J and n_J < len(arrInputList)):
        return False

    if (arrInputList[n_I] + arrInputList[n_J]) % n_K > 0:
        return False

    return True


arrIndxList = list(range(0, len(arrInputList)))
arrCombList = combinations(arrIndxList, 2)
arrOutputList = []

for loopComb in list(arrCombList):
    if IsSatisfyRule(loopComb):
        arrOutputList.append(loopComb)

print (len(arrOutputList))
