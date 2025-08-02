
def IsPosSpecial (arrInput, nRow, nCol):
    if arrInput[nRow][nCol] == 0:
        return False

    for nRowLoop in range(len(arrInput)):
        if nRowLoop == nRow:
            continue
        if arrInput[nRowLoop][nCol] == 1:
            return False

    for nColLoop in range(len(arrInput[0])):
        if nColLoop == nCol:
            continue
        if arrInput[nRow][nColLoop] == 1:
            return False

    return True

## arrMatrix = [[1, 0, 0], [0, 0, 1], [1, 0, 0]]  ## Example 1
arrMatrix = [[1, 0, 0], [0, 1, 0], [0, 0, 1]]  ## Example 2

arrOutput = [[nRowIndx, nColIndx] for nRowIndx in range(len(arrMatrix)) for nColIndx in range(len(arrMatrix[0])) if IsPosSpecial (arrMatrix, nRowIndx, nColIndx)]

print (len(arrOutput))
