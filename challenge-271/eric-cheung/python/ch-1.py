
import numpy as np

## arrMatrix = [[0, 1], [1, 0]]  ## Example 1
## arrMatrix = [[0, 0, 0], [1, 0, 1]]  ## Example 2
arrMatrix = [[0, 0], [1, 1], [0, 0]]  ## Example 3

arrNumOne = [arrMatrix[nLoop].count(1) for nLoop in range(len(arrMatrix))]

print (np.argmax(arrNumOne) + 1)
