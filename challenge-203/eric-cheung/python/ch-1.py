
from itertools import combinations

## arrInputList = [1, 2, 3, 6]  ## Example 1
## arrInputList = [1, 1, 1, 3, 5]  ## Example 2
arrInputList = [3, 3, 6, 4, 5]  ## Example 2


def IsSpecialQuadruplets(arrInput):

    n_a = arrInput[0]
    n_b = arrInput[1]
    n_c = arrInput[2]
    n_d = arrInput[3]

    return (arrInputList[n_a] + arrInputList[n_b] + arrInputList[n_c] == arrInputList[n_d])


arrIndxList = list(range(0, len(arrInputList)))
arrCombList = combinations(arrIndxList, 4)
arrOutputList = []

for loopComb in list(arrCombList):
    if IsSpecialQuadruplets(loopComb):
        arrOutputList.append(loopComb)

print (len(arrOutputList))
