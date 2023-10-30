
from itertools import permutations

def GetGreatness (arrNum, arrPerm):
    return len([nIndx for nIndx in range(len(arrNum)) if arrNum[nIndx] < arrPerm[nIndx]])

## arrNumList = [1, 3, 5, 2, 1, 3, 1]  ## Example 1
arrNumList = [1, 2, 3, 4]  ## Example 2

arrPermList = permutations(arrNumList)

arrGreatness = [GetGreatness (arrNumList, arrPermLoop) for arrPermLoop in list(arrPermList)]

print (max(arrGreatness))
