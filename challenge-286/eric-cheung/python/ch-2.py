
def GetNumMinMax (arrGiven, bIsMax = True):
    return sorted(arrGiven, reverse = bIsMax)[0]

def GetLastElem (arrInput):
    if len(arrInput) == 2:
        return GetNumMinMax(arrInput, False)

    return GetLastElem ([GetNumMinMax(arrInput[nLoop * 2: (nLoop + 1) * 2], nLoop % 2 == 1) for nLoop in range(0, int(len(arrInput) / 2))])

## arrInts = [2, 1, 4, 5, 6, 3, 0, 2]  ## Example 1
## arrInts = [0, 5, 3, 2]  ## Example 2
arrInts = [9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8]  ## Example 3

print (GetLastElem (arrInts))
