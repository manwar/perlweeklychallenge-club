
## Example 1
## arrX = [3, 7, 5]
## arrY = [9, 5, 7]

## Example 2
## arrX = [1, 2, 1]
## arrY = [5, 4, 4]

## Example 3
arrX = [2]
arrY = [5]

arrX = sorted(arrX)
arrY = sorted(arrY)

nDiff = arrY[0] - arrX[0]

bIsSameDiff = True
for nIndx in range(1, len(arrX)):
    if arrY[nIndx] - arrX[nIndx] != nDiff:
        bIsSameDiff = False
        break

print (nDiff if bIsSameDiff else "")
