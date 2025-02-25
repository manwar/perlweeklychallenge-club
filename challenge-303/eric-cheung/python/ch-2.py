
arrInt = [3, 4, 2]  ## Example 1
## arrInt = [2, 2, 3, 3, 3, 4]  ## Example 2

def GetPoint (nElem, arrInput):
    arrTemp = arrInput[:]
    nTemp = nElem * arrTemp.count(nElem)

    for nIndx in range(arrTemp.count(nElem)):
        arrTemp.remove(nElem)

    for nIndx in range(arrTemp.count(nElem - 1)):
        arrTemp.remove(nElem - 1)

    for nIndx in range(arrTemp.count(nElem + 1)):
        arrTemp.remove(nElem + 1)

    return [nTemp, arrTemp]

nMax = 0

for nLoop in sorted(set(arrInt), reverse = True):
    nPoint, arrRemain = GetPoint (nLoop, arrInt)

    while len(arrRemain) > 0:
        nTempPoint, arrRemain = GetPoint (max(arrRemain), arrRemain)
        nPoint = nPoint + nTempPoint

    nMax = max(nMax, nPoint)

print (nMax)
