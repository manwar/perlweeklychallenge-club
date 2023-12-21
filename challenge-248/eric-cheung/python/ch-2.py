
## arrMatrixInput = [[1,  2,  3,  4], [5,  6,  7,  8], [9, 10, 11, 12]]  ## Example 1
arrMatrixInput = [[1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]  ## Example 2

arrMatrixOutput = []

for nRow in range(len(arrMatrixInput) - 1):
    arrRow = []
    for nCol in range(len(arrMatrixInput[nRow]) - 1):
        arrRow.append(arrMatrixInput[nRow][nCol] + arrMatrixInput[nRow][nCol + 1] + arrMatrixInput[nRow + 1][nCol] + arrMatrixInput[nRow + 1][nCol + 1])
    arrMatrixOutput.append(arrRow)

print (arrMatrixOutput)
