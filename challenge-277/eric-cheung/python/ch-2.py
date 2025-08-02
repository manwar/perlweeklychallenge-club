
from itertools import combinations

def IsStrongPair (arrInput):
    if abs(arrInput[0] - arrInput[1]) > 0 and min(arrInput) > abs(arrInput[0] - arrInput[1]):
        return True
    return False

## arrInt = [1, 2, 3, 4, 5]  ## Example 1
arrInt = [5, 7, 1, 7]  ## Example 2

arrComb = combinations(arrInt, 2)

arrOutput = [arrLoop for arrLoop in list(set(arrComb)) if IsStrongPair(arrLoop)]

print (len(arrOutput))
