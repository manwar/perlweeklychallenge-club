##

import numpy as np

## Example 1
## arrList = np.array([1, 4, 2, 3, 5])
## nVal = 3

## Example 2
arrList = np.array([9, 0, 6, 2, 3, 8, 5])
nVal = 4

nIndxArr = np.where(arrList > nVal)

print (arrList[nIndxArr])
