
import sys

## Example 1
## arrSource = [3, 2, 1, 4]
## arrTarget = [1, 2, 3, 4]

## Example 2
## arrSource = [1, 3, 4]
## arrTarget = [4, 1, 3]

## Example 3
arrSource = [2]
arrTarget = [2]

if len(arrSource) == 1:
    print (True)
    sys.exit()

for nRowIndx in range(len(arrSource) - 1):
    for nColIndx in range(nRowIndx + 1, len(arrSource)):
        ## print (nRowIndx, nColIndx)
        arrRevTemp = arrSource[nRowIndx : nColIndx + 1][::-1]
        arrTemp = arrSource[:nRowIndx] + arrRevTemp + arrSource[nColIndx + 1:]

        if arrTarget == arrTemp:
            print (True)
            sys.exit()

print (False)
sys.exit()
