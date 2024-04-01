
from itertools import combinations

## Example 1
## arrInt = [3, 1, 2, 2, 2, 1, 3]
## nK = 2

## Example 2
arrInt = [1, 2, 3]
nK = 1

arrCombList = combinations(range(len(arrInt)), 2)

arrOutput = [arrIndxLoop for arrIndxLoop in list(arrCombList) if arrInt[arrIndxLoop[0]] == arrInt[arrIndxLoop[1]] and arrIndxLoop[0] * arrIndxLoop[1] % nK == 0]

print (len(arrOutput))
