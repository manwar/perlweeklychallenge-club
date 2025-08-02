
import numpy as np

## Example 1
## arrInt = [1, 2, 3, 4]
## nRow = 2
## nCol = 2

## Example 2
## arrInt = [1, 2, 3]
## nRow = 1
## nCol = 3

## Example 3
arrInt = [1, 2, 3, 4]
nRow = 4
nCol = 1

arrOutput = np.array(arrInt).reshape((nRow, nCol)).tolist()

print (arrOutput)
