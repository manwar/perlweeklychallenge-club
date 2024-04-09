
## Example 1
## arrSrc = [0, 1, 2, 3, 4]
## arrIndx = [0, 1, 2, 2, 1]

## Example 2
## arrSrc = [1, 2, 3, 4, 0]
## arrIndx = [0, 1, 2, 3, 0]

## Example 3
arrSrc = [1]
arrIndx = [0]

arrTarget = []
for nIndx, nElemLoop in enumerate(arrSrc):
    arrTarget.insert(arrIndx[nIndx], nElemLoop) 

print (arrTarget)
