
from math import sqrt

def GetPrimeFact(nInput):
    if nInput < 2:
        return []
    if nInput == 2:
        return [2]

    ## ====== ##
    nNum = nInput
    arrOuput = []
    while nNum % 2 == 0:
        arrOuput.append(2)
        nNum = int(nNum / 2)
    ## ====== ##

    ## ====== ##
    nDiv = 3
    nRoot = int(sqrt(nNum))
    while nDiv < nRoot + 1:
        if nNum % nDiv == 0:
            arrOuput.append(nDiv)
            nNum = int(nNum / nDiv)
        else:
            nDiv = nDiv + 2
    ## ====== ##

    return arrOuput

arrInput = [11, 8, 27, 4]

for nRowIndx in range(0, len(arrInput) - 1):
    for nColIndx in range(nRowIndx + 1, len(arrInput)):
        if len(GetPrimeFact(arrInput[nRowIndx])) > len(GetPrimeFact(arrInput[nColIndx])) or len(GetPrimeFact(arrInput[nRowIndx])) == len(GetPrimeFact(arrInput[nColIndx])) and arrInput[nRowIndx] > arrInput[nColIndx]:
            nTemp = arrInput[nRowIndx]
            arrInput[nRowIndx] = arrInput[nColIndx]
            arrInput[nColIndx] = nTemp

print (arrInput)
