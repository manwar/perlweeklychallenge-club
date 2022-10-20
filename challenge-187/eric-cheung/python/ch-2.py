
from itertools import permutations

def IsSatisfyRule(arrInput):

    n_A = arrInput[0]
    n_B = arrInput[1]
    n_C = arrInput[2]

    if n_A + n_B <= n_C:
        return 0

    if n_B + n_C <= n_A:
        return 0

    if n_A + n_C <= n_B:
        return 0

    return n_A + n_B + n_C


def PickList(arrList):

    for arrLoop in arrList:

        n_A = arrLoop[0]
        n_B = arrLoop[1]
        n_C = arrLoop[2]

        if n_A >= n_B and n_B >= n_C:
            return arrLoop

nPick = 3

## arrInputList = [1, 2, 3, 2]  ## Example 1
## arrInputList = [1, 3, 2]  ## Example 2
## arrInputList = [1, 1, 2, 3]  ## Example 3
arrInputList = [2, 4, 3]  ## Example 4

if len(arrInputList) < nPick:
    print ("")
else:
    arrPermuList = permutations(arrInputList, nPick)

    nSumMax = 0
    arrTriple = []

    for compLoop in list(arrPermuList):
        nSumMaxLoop = IsSatisfyRule(compLoop)

        if nSumMaxLoop == 0:
            continue

        if nSumMaxLoop > nSumMax:
            nSumMax = nSumMaxLoop
            arrTriple = []
            arrTriple.append(compLoop)
        elif nSumMaxLoop == nSumMax:
            arrTriple.append(compLoop)

    if len(arrTriple) > 0:
        if len(arrTriple) == 1:
            print (arrTriple)
        else:
            print (PickList(arrTriple))
    else:
        print ("")
