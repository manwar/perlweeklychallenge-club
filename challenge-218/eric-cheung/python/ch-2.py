
arrMatrix = [[0, 0, 1, 1], [1, 0, 1, 0], [1, 1, 0, 0]]
## arrMatrix = [[0]]  ## Example 2

nMatrixSum = 0

def GetSum (arrInputMat):

    nSum = 0

    for nIndx in range(0, len(arrInputMat)):
        nSum = nSum + int("".join([str(nElem) for nElem in arrInputMat[nIndx]]), 2)

    return nSum

def SwapAlongRow (arrInputMat, nRowIndx):

    for nIndx in range(0, len(arrMatrix[0])):
        arrInputMat[nRowIndx][nIndx] = 1 - arrInputMat[nRowIndx][nIndx]

    return

def SwapAlongCol (arrInputMat, nColIndx):

    for nIndx in range(0, len(arrMatrix)):
        arrInputMat[nIndx][nColIndx] = 1 - arrInputMat[nIndx][nColIndx]

    return


if len(arrMatrix) == 1 and len(arrMatrix[0]) == 1:
    print (1)
else:
    ## Swap Along Rows
    for nRowLoopIndx in range(0, len(arrMatrix)):
        arrTempMatrix = [arrRow[:] for arrRow in arrMatrix]
        SwapAlongRow (arrTempMatrix, nRowLoopIndx)
        if GetSum (arrTempMatrix) > nMatrixSum:
            SwapAlongRow (arrMatrix, nRowLoopIndx)
            nMatrixSum = GetSum (arrMatrix)

    ## Swap Along Columns
    for nColLoopIndx in range(0, len(arrMatrix[0])):
        arrTempMatrix = [arrRow[:] for arrRow in arrMatrix]
        SwapAlongCol (arrTempMatrix, nColLoopIndx)
        if GetSum (arrTempMatrix) > nMatrixSum:
            SwapAlongCol (arrMatrix, nColLoopIndx)
            nMatrixSum = GetSum (arrMatrix)

    ## print (arrMatrix)
    print (nMatrixSum)
