
import numpy as np

## arrInts = [8000, 5000, 6000, 2000, 3000, 7000]  ## Example 1
## arrInts = [100000, 80000, 110000, 90000]  ## Example 2
## arrInts = [2500, 2500, 2500, 2500]  ## Example 3
## arrInts = [2000]  ## Example 4
arrInts = [1000, 2000, 3000, 4000, 5000, 6000]  ## Example 5

arrMinMax = [max(arrInts), min(arrInts)]

arrOutput = [nElem for nElem in arrInts if nElem not in arrMinMax]

print (np.mean(arrOutput) if len(arrOutput) > 0 else 0)
