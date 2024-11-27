
from itertools import permutations

## arrInput = [1, 2, 3]  ## Example 1
## arrInput = [2, 1, 3]  ## Example 2
arrInput = [3, 1, 2]  ## Example 3

arrPermList = [list(arrSet) for arrSet in list(permutations(arrInput))]

## print (arrPermList)

print (arrPermList[arrPermList.index(arrInput) + 1])
