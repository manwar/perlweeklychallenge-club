
def IsMonotone(arrInput):

    bConstantArr = True
    bMontoneInc = False

    for nLastIndx in range(1, len(arrInput)):
        if arrInput[nLastIndx - 1] == arrInput[nLastIndx]:
            continue

        bConstantArr = False

        if arrInput[nLastIndx - 1] < arrInput[nLastIndx]:
            bMontoneInc = True
            break

        break

    if bConstantArr:
        return "1"

    for nLoopIndx in range(nLastIndx + 1, len(arrInput)):
        if bMontoneInc and arrInput[nLoopIndx - 1] > arrInput[nLoopIndx] or not bMontoneInc and arrInput[nLoopIndx - 1] < arrInput[nLoopIndx]:
            return "0"

    return "1"


## nInputArr = [1, 2, 2, 3]  ## Example 1
## nInputArr = [1, 3, 2]  ## Example 2
nInputArr = [6, 5, 5, 4]  ## Example 3

print (IsMonotone(nInputArr))
