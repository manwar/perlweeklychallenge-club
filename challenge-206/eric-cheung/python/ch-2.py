
from itertools import combinations

def GetSetFromArrInput(arrFuncInput):

    arrOutputArr = []

    arrCombList = combinations(arrFuncInput, 2)

    for loopComb in list(arrCombList):
        arrOutputArr.append([loopComb[0], loopComb[1]])

    return arrOutputArr


## arrInput = [1, 2, 3, 4]  ## Example 1
arrInput = [0, 2, 1, 3]  ## Example 2

arrCombSubList = combinations(range(0, len(arrInput)), 2)

arrSumOutput = []

for loopSubComb in list(arrCombSubList):

    arrSubInput = arrInput[:]

    arrSubList_01 = [arrSubInput[loopSubComb[0]], arrSubInput[loopSubComb[1]]]

    arrSubInput.pop(loopSubComb[1])
    arrSubInput.pop(loopSubComb[0])

    arrSubList_02 = GetSetFromArrInput(arrSubInput)

    for nLoop in range(0, len(arrSubList_02)):

        if arrSubList_01[0] > arrSubList_02[nLoop][0]:
            continue

        arrSumOutput.append(min(arrSubList_01) + min(arrSubList_02[nLoop]))

print (max(arrSumOutput))
