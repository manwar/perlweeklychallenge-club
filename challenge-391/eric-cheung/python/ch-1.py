import numpy as np

## Example 1
## arrList_01 = [2]
## arrList_02 = [4]

## Example 2
## arrList_01 = [1, 2, 3]
## arrList_02 = [7, 8, 9, 10]

## Example 3
## arrList_01 = []
## arrList_02 = [10, 20, 30, 40]

## Example 4
## arrList_01 = [100]
## arrList_02 = [1, 2, 3, 4, 5, 6, 7]

## Example 5
arrList_01 = [1, 2, 2]
arrList_02 = [2, 2, 3]

arrList_Merge = arrList_01 + arrList_02

dMedianVal = np.median(arrList_Merge)

print (dMedianVal)