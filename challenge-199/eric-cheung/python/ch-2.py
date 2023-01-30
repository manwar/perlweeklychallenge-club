
from itertools import combinations

def get_GoodTriplets_List(arrInput, arrInputInt):

    arrGoodPairsList = []

    nIndxTuple = combinations(range(0, len(arrInput)), 3)

    for nIndxLoop_01, nIndxLoop_02, nIndxLoop_03 in list(nIndxTuple):
        if abs(arrInput[nIndxLoop_01] - arrInput[nIndxLoop_02]) <= arrInputInt[0] and abs(arrInput[nIndxLoop_02] - arrInput[nIndxLoop_03]) <= arrInputInt[1] and abs(arrInput[nIndxLoop_01] - arrInput[nIndxLoop_03]) <= arrInputInt[2]:
            arrGoodPairsList.append([nIndxLoop_01, nIndxLoop_02, nIndxLoop_03])

    return arrGoodPairsList


## Example 1
## arrInputList = [3, 0, 1, 1, 9, 7]
## arrInputList_Int = [7, 2, 3]

## Example 2
arrInputList = [1, 1, 2, 2, 3]
arrInputList_Int = [0, 0, 1]

print (len(get_GoodTriplets_List(arrInputList, arrInputList_Int)))
