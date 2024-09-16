
## Example 1
## arrList_01 = [2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5]
## arrList_02 = [2, 1, 4, 3, 5, 6]

## Example 2
## arrList_01 = [3, 3, 4, 6, 2, 4, 2, 1, 3]
## arrList_02 = [1, 3, 2]

## Example 3
arrList_01 = [3, 0, 5, 0, 2, 1, 4, 1, 1]
arrList_02 = [1, 0, 3, 2]

arrOutput = []

## Contain
for nLoop in arrList_02:
    arrOutput = arrOutput + [nLoop] * arrList_01.count(nLoop)

## Miss
for nLoop in [rLoop for rLoop in set(arrList_01) if rLoop not in arrList_02]:
    arrOutput = arrOutput + [nLoop] * arrList_01.count(nLoop)

print (arrOutput)
