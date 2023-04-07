
## arrMatrixInput = [[4, 3, 2, 1], [5, 4, 3, 2], [6, 5, 4, 3]]  ## Example 1
arrMatrixInput = [[1, 2, 3], [3, 2, 1]]  ## Example 2

nMatrixRow = len(arrMatrixInput)
nMatrixCol = len(arrMatrixInput[0])

nMinIndx = min(nMatrixRow, nMatrixCol)

bIsToeplitzMatrix = True
nDiagElem = arrMatrixInput[0][0]
for nIndxLoop in range(1, nMinIndx):
    if arrMatrixInput[nIndxLoop][nIndxLoop] != nDiagElem:
        bIsToeplitzMatrix = False
        break

print (bIsToeplitzMatrix)
