
import numpy as np

def GetSlope (arrPt_1, arrPt_2):
    dX1, dY1 = arrPt_1
    dX2, dY2 = arrPt_2

    if dX1 == dX2:
        return np.nan

    return (dY2 - dY1) / (dX2 - dX1)

## arrList = [[2, 1], [2, 3], [2, 5]]  ## Example 1
## arrList = [[1, 4], [3, 4], [10, 4]]  ## Example 2
## arrList = [[0, 0], [1, 1], [2, 3]]  ## Example 3
## arrList = [[1, 1], [1, 1], [1, 1]]  ## Example 4
arrList = [[1000000, 1000000], [2000000, 2000000], [3000000, 3000000]]  ## Example 5

arrX = [arrLoop[0] for arrLoop in arrList]
arrY = [arrLoop[1] for arrLoop in arrList]

if len(set(arrX)) == 1 or len(set(arrY)) == 1:
    print (True)
else:
    arrSlope = [GetSlope(arrList[nIndx - 1], arrList[nIndx]) for nIndx in range(1, len(arrList))]
    print (len(set(arrSlope)) == 1)
