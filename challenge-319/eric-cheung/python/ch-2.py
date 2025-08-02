
## Example 1
## arrList_01 = [1, 2, 3, 4]
## arrList_02 = [3, 4, 5, 6]

## Example 2
## arrList_01 = [1, 2, 3]
## arrList_02 = [2, 4]

## Example 3
arrList_01 = [1, 2, 3, 4]
arrList_02 = [5, 6, 7, 8]

arrOutput = [nLoop for nLoop in arrList_01 if nLoop in arrList_02]

print (-1 if len(arrOutput) == 0 else min(arrOutput))
