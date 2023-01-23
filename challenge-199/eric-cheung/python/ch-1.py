
from itertools import combinations

def get_GoodPairs_List(arrInput):

    arrGoodPairsList = []

    nIndxTuple = combinations(range(0, len(arrInput)), 2)

    for nIndxLoop_01, nIndxLoop_02 in list(nIndxTuple):
        if arrInput[nIndxLoop_01] == arrInput[nIndxLoop_02]:
            arrGoodPairsList.append([nIndxLoop_01, nIndxLoop_02])

    return arrGoodPairsList

## arrInputList = [1, 2, 3, 1, 1, 3]  ## Example 1
## arrInputList = [1, 2, 3]  ## Example 2
arrInputList = [1, 1, 1, 1]  ## Example 3

print (len(get_GoodPairs_List(arrInputList)))
