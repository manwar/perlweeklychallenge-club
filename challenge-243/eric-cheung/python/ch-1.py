
from itertools import combinations

def IsReversePair (arrInput):
    if arrInput[0] > 2 * arrInput[1]:
        return True
    return False


## arrNum = [1, 3, 2, 3, 1]  ## Example 1
arrNum = [2, 4, 3, 5, 1]  ## Example 2


arrCombList = combinations(arrNum, 2)
arrOutputList = [arrLoop for arrLoop in list(arrCombList) if IsReversePair(arrLoop)]


print (len(arrOutputList))
