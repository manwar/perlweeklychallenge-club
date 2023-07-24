
import numpy as np

## arrInput = np.array([1, 5, 0, 3, 5])  ## Example 1
## arrInput = np.array([0])  ## Example 2
arrInput = np.array([2, 1, 4, 0, 3])  ## Example 3

nCount = 0

while np.count_nonzero(arrInput) > 0:
    nSubstract = min([nLoop for nLoop in arrInput if nLoop > 0])
    arrInput = [nLoop - nSubstract if nLoop > 0 else 0 for nLoop in arrInput]
    nCount = nCount + 1

print (nCount)
