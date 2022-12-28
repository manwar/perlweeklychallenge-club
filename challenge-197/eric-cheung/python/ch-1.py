
import numpy as np

## arrInputList = np.array([1, 0, 3, 0, 0, 5])  ## Example 1
## arrInputList = np.array([1, 6, 4])  ## Example 2
arrInputList = np.array([0, 1, 0, 2, 0])  ## Example 3

arrOutputList = np.append(arrInputList[arrInputList != 0], arrInputList[arrInputList == 0])

print (arrOutputList)
