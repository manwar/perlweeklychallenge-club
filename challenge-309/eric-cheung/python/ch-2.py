
from itertools import combinations

## arrInts = [1, 5, 8, 9]  ## Example 1
arrInts = [9, 4, 1, 7]  ## Example 2

objComb = combinations(arrInts, 2)

arrDiff = [abs(arrLoop[0] - arrLoop[1]) for arrLoop in list(objComb)]

print (min(arrDiff))
