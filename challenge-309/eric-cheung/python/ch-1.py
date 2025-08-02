
import numpy as np

## arrInts = [2, 8, 10, 11, 15]  ## Example 1
## arrInts = [1, 5, 6, 7, 14]  ## Example 2
arrInts = [8, 20, 25, 28]  ## Example 3

arrDiff = [arrInts[nIndx] - arrInts[nIndx - 1] for nIndx in range(1, len(arrInts))]

## print (arrDiff)
## print (np.argmin(arrDiff))

nMinDiffIndx = np.argmin(arrDiff)

print (arrInts[nMinDiffIndx + 1])
