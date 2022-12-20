
from itertools import combinations

def get_Pattern132_List(arrInput):

    nIndxTuple = combinations(range(0, len(arrInput)), 3)

    for nIndxLoop_01, nIndxLoop_02, nIndxLoop_03 in list(nIndxTuple):
        ## if arrInput[nIndxLoop_01] < arrInput[nIndxLoop_03] and arrInput[nIndxLoop_03] < arrInput[nIndxLoop_02]:
        if arrInput[nIndxLoop_01] < arrInput[nIndxLoop_03] < arrInput[nIndxLoop_02]:
            return [arrInput[nIndxLoop_01], arrInput[nIndxLoop_02], arrInput[nIndxLoop_03]]

arrInputList = [3, 1, 4, 2]  ## Example 1
## arrInputList = [1, 2, 3, 4]  ## Example 2
## arrInputList = [1, 3, 2, 4, 6, 5]  ## Example 3
## arrInputList = [1, 3, 4, 2]  ## Example 4

print (get_Pattern132_List(arrInputList))
