
from itertools import combinations

def IsAriTriplet (arrInput, nDiffInput):
    if arrInput[1] - arrInput[0] != nDiffInput:
        return False
    if arrInput[2] - arrInput[1] != nDiffInput:
        return False
    return True


## Example 1
## arrNum = [0, 1, 4, 6, 7, 10]
## nDiff = 3

## Example 2
arrNum = [4, 5, 6, 7, 8, 9]
nDiff = 2


arrCombList = combinations(arrNum, 3)
arrOutputList = []

for arrLoop in list(arrCombList):
    if IsAriTriplet(arrLoop, nDiff):
        arrOutputList.append(arrOutputList)

print (len(arrOutputList))
