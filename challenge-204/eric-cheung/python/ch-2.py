
import numpy as np

## Example 1
## matrixInput = np.array([[1, 2], [3, 4]])
## nMatrixReShapeRow = 1
## nMatrixReShapeCol = 4

## Example 2
## matrixInput = np.array([[1, 2, 3], [4, 5, 6]])
## nMatrixReShapeRow = 3
## nMatrixReShapeCol = 2

## Example 3
matrixInput = np.array([1, 2])
nMatrixReShapeRow = 3
nMatrixReShapeCol = 2


nMatrixRow = len(matrixInput)

try:
    nMatrixCol = len(matrixInput[0])
except:
    nMatrixCol = 0


if nMatrixRow * nMatrixCol != nMatrixReShapeRow * nMatrixReShapeCol:
    print ("0")
else:
    matrixOutput = matrixInput.reshape(nMatrixReShapeRow, nMatrixReShapeCol)
    print (matrixOutput)
