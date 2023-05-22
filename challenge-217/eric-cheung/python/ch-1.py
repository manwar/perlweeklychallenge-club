
import numpy as np

## arrMatrix = np.array([[3, 1, 2], [5, 2, 4], [0, 1, 3]])  ## Example 1
## arrMatrix = np.array([[2, 1], [4, 5]])  ## Example 2
arrMatrix = np.array([[1, 0, 3], [0, 0, 0], [1, 2, 1]])  ## Example 3

arrList = arrMatrix.flatten()
arrList.sort()

if len(arrList) >= 3:
    print (arrList[2])
else:
    print (0)
