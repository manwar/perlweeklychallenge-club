
def IsBoomerang (arrInput):
    arrUniqPoints = []
    for arrPointLoop in arrInput:
        if arrPointLoop in arrUniqPoints:
            return False
        arrUniqPoints.append(arrPointLoop)

    arrSlopeVal = []
    for nIndx in range(1, len(arrUniqPoints)):
        dYDiff = arrUniqPoints[nIndx][1] - arrUniqPoints[nIndx - 1][1]
        dXDiff = arrUniqPoints[nIndx][0] - arrUniqPoints[nIndx - 1][0]
        arrSlopeVal.append("-" if dXDiff == 0 else str(dYDiff / dXDiff))

    return (len(set(arrSlopeVal)) > 1)

## arrPoints = [[1, 1], [2, 3], [3, 2]]  ## Example 1
## arrPoints = [[1, 1], [2, 2], [3, 3]]  ## Example 2
## arrPoints = [[1, 1], [1, 2], [2, 3]]  ## Example 3
## arrPoints = [[1, 1], [1, 2], [1, 3]]  ## Example 4
## arrPoints = [[1, 1], [2, 1], [3, 1]]  ## Example 5
arrPoints = [[0, 0], [2, 3], [4, 5]]  ## Example 6

print (IsBoomerang(arrPoints))
