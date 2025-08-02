
def IsXMatrix (arrInputMatrix):

    nLen = len(arrInputMatrix)

    ## Check
    for nRowIndx in range(nLen):

        nColIndx_01 = nRowIndx
        nColIndx_02 = nLen - nRowIndx - 1

        ## 1st
        if arrInputMatrix[nRowIndx][nColIndx_01] == 0:
            return False

        ## 2nd
        if arrInputMatrix[nRowIndx][nColIndx_02] == 0:
            return False

        ## 3rd
        for nColIndx in range(nLen):
            if nColIndx in [nColIndx_01, nColIndx_02]:
                continue

            if arrInputMatrix[nRowIndx][nColIndx] != 0:
                return False

    return True

## arrMatrix = [[1, 0, 0, 2], [0, 3, 4, 0], [0, 5, 6, 0], [7, 0, 0, 1]]  ## Example 1
## arrMatrix = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]  ## Example 2
arrMatrix = [[1, 0, 2], [0, 3, 0], [4, 0, 5]]  ## Example 3

print (IsXMatrix (arrMatrix))
