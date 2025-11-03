
## arrInts = [1, 3, 2]  ## Example 1
## arrInts = [2, 4, 6, 5, 3]  ## Example 2
## arrInts = [1, 2, 3, 2, 4, 1]  ## Example 3
## arrInts = [5, 3, 1]  ## Example 4
arrInts = [1, 5, 1, 5, 1, 5, 1]  ## Example 5

arrOutput = []

for nIndx, nElem in enumerate(arrInts):
    bIsPeak = False

    if nIndx == 0 and nElem > arrInts[nIndx + 1]:
        bIsPeak = True
    elif nIndx == len(arrInts) - 1 and nElem > arrInts[nIndx - 1]:
        bIsPeak = True
    elif nElem > arrInts[nIndx - 1] and nElem > arrInts[nIndx + 1]:
        bIsPeak = True

    if bIsPeak:
        arrOutput.append(nIndx)

print (arrOutput)
