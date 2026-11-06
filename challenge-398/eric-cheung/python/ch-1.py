
from statistics import mean

## arrInput = [18, 5, 7, 11]  ## Example 1
## arrInput = [6, 12, 18, 24, 30, 40]  ## Example 2
## arrInput = [3, 9, 15, 21, 27]  ## Example 3
## arrInput = [6, 12, 14, 20]  ## Example 4
arrInput = [6, 6, 6, 12, 12]  ## Example 5

arrOutput = [nElem for nElem in arrInput if nElem % 6 == 0]

if len(arrOutput) == 0:
    print (0)
else:
    nOutput = round(mean(arrOutput))
    print (nOutput)
