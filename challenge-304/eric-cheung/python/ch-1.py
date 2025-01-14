
from itertools import combinations

def IsConsecTwoOne (arrInput, arrRelacePos):
    arrTemp = arrInput[:]
    for nPos in arrRelacePos:
        arrTemp[nPos] = 1

    arrOutput = [nIndx for nIndx in range(1, len(arrTemp)) if arrTemp[nIndx - 1] == 1 and arrTemp[nIndx] == 1]

    return (len(arrOutput) > 0)

## Example 1
## arrDigits = [1, 0, 0, 0, 1]
## nN = 1

## Example 2
arrDigits = [1, 0, 0, 0, 1]
nN = 2

arrZeroPos = [nIndx for nIndx, nElem in enumerate(arrDigits) if nElem == 0]

objComb = combinations(arrZeroPos, nN)

bFlag = False
for arrLoop in list(objComb):
    if IsConsecTwoOne (arrDigits, list(arrLoop)):
        continue

    bFlag = True
    break

print (bFlag)
