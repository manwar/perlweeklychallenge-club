
import sys
from itertools import combinations
import numpy as np

nListCount = 3

arrInput = [4, 4, 2, 4, 3]  ## Example 1
## arrInput = [1, 1, 1, 1, 1]  ## Example 2
## arrInput = [4, 7, 1, 10, 7, 4, 1, 1]  ## Example 3

arrUniq = list(set(arrInput))

## print (arrUniq)

if len(arrUniq) < nListCount:
    print (0)
    sys.exit()

nNumCount = 0

arrCombList = combinations(arrUniq, nListCount)

for arrCombLoop in list(arrCombList):
    nProduct = np.prod([arrInput.count(arrCombLoop[nLoop]) for nLoop in range(nListCount)])
    nNumCount = nNumCount + nProduct

print (nNumCount)
