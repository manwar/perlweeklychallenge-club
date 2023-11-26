
from itertools import combinations

def GetFloorSum (arrInput):
    return int(arrInput[0] / arrInput[1]) + int(arrInput[1] / arrInput[0])

## arrNum = [2, 5, 9]  ## Example 1
arrNum = [7, 7, 7, 7, 7, 7, 7]  ## Example 2

arrCombList = combinations(arrNum, 2)
nSum = len(arrNum) + sum([GetFloorSum(arrLoop) for arrLoop in list(arrCombList)])

print (nSum)
