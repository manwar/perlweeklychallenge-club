
from itertools import combinations

## arrInputList = [1, 2, 3, 4, 5, 6, 7]  ## Example 1
## arrInputList = [2, 4, 1, 3]  ## Example 2
arrInputList = [10, 5, 7, 12, 8]  ## Example 3

arrInputList.sort()

arrCombList = combinations(arrInputList, 2)

arrOutputList = []

for loopComb in list(arrCombList):
    arrOutputList.append(loopComb[0] ^ loopComb[1])

print (max(arrOutputList))
