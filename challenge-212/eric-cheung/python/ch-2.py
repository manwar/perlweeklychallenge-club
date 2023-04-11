
## Example 1:
## arrList = [1, 2, 3, 5, 1, 2, 7, 6, 3]
## nSizeSplit = 3

## Example 2:
## arrList = [1, 2, 3]
## nSizeSplit = 2

## Example 3:
## arrList = [1, 2, 4, 3, 5, 3]
## nSizeSplit = 3

## Example 4:
arrList = [1, 5, 2, 6, 4, 7]
nSizeSplit = 3

if len(arrList) % nSizeSplit == 0:
    arrList.sort()
    for nIndx in range(0, len(arrList), nSizeSplit):
        print (arrList[nIndx:nIndx + nSizeSplit])
else:
    print (-1)
