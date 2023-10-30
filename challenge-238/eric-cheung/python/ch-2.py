
from numpy import prod

def GetStep (nStep, nInput):
    if nInput < 10:
        return nStep
    return GetStep (nStep + 1, prod([int(charLoop) for charLoop in str(nInput)]))

## print (GetStep(0, 1))

## arrInput = [15, 99, 1, 34]  ## Example 1
arrInput = [50, 25, 33, 22]  ## Example 2

arrOutput = arrInput[:]

for nRow in range(0, len(arrOutput) - 1):
    for nCol in range(nRow + 1, len(arrOutput)):
        if GetStep (0, arrOutput[nRow]) > GetStep (0, arrOutput[nCol]) or GetStep (0, arrOutput[nRow]) == GetStep (0, arrOutput[nCol]) and arrOutput[nRow] > arrOutput[nCol]:
            vTemp = arrOutput[nRow]
            arrOutput[nRow] = arrOutput[nCol]
            arrOutput[nCol] = vTemp

print (arrOutput)
