
def IsStrictInc (arrCheck):

    for nIndx in range(1, len(arrCheck)):
        if arrCheck[nIndx] <= arrCheck[nIndx - 1]:
            return False

    return True

## arrInput = [0, 2, 9, 4, 6]  ## Example 1
## arrInput = [5, 1, 3, 2]  ## Example 2
arrInput = [2, 2, 3]  ## Example 3

bIsRemoveOne = False

for nLoop in range(len(arrInput)):
    arrTemp = arrInput[:]
    arrTemp.pop(nLoop)
    if IsStrictInc (arrTemp):
        bIsRemoveOne = True
        break

print (bIsRemoveOne)
