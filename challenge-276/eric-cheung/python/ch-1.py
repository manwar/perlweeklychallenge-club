
from itertools import combinations

## arrHours = [12, 12, 30, 24, 24]  ## Example 1
## arrHours = [72, 48, 24, 5]  ## Example 2
arrHours = [12, 18, 24]  ## Example 3

arrComb = combinations(arrHours, 2)

arrOutput = [arrLoop for arrLoop in list(arrComb) if sum(arrLoop) % 24 == 0]

print (len(arrOutput))
