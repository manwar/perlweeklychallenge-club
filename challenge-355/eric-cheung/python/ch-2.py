
def IsMountainArr (arrInput):
    if len(arrInput) < 3:
        return False

    for nIndx in range(1, len(arrInput) - 1):
        arrPart_01 = [arrInput[nSubIndx] < arrInput[nSubIndx + 1] for nSubIndx in range(nIndx)]
        arrPart_02 = [arrInput[nSubIndx] > arrInput[nSubIndx + 1] for nSubIndx in range(nIndx, len(arrInput) - 1)]

        if all(arrPart_01) and all(arrPart_02):
            return True

    return False

## arrInt = [1, 2, 3, 4, 5]  ## Example 1
## arrInt = [0, 2, 4, 6, 4, 2, 0]  ## Example 2
## arrInt = [5, 4, 3, 2, 1]  ## Example 3
## arrInt = [1, 3, 5, 5, 4, 2]  ## Example 4
arrInt = [1, 3, 2]  ## Example 5

print (IsMountainArr(arrInt))
