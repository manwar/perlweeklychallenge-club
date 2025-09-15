
from math import prod

## Ref.:

## arrInts = [5, 9, 3, 4, 6]  ## Example 1
## arrInts = [1, -2, 3, -4]  ## Example 2
## arrInts = [-3, -1, -2, -4]  ## Example 3
## arrInts = [10, 2, 0, 5, 1]  ## Example 4
arrInts = [7, 8, 9, 10, 10]  ## Example 5

arrInts = sorted(arrInts)

if all(nElem >= 0 for nElem in arrInts) or all(nElem <= 0 for nElem in arrInts):
    print (abs(prod(arrInts[-2:]) - prod(arrInts[:2])))
else:
    print (arrInts[-3] * arrInts[-2] - arrInts[0] * arrInts[-1])
