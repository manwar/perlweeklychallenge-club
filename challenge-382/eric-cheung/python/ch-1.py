from math import sqrt

def CheckIsSqr(nNumInput):
    nSqrRt = int(sqrt(nNumInput))
    return nSqrRt * nSqrRt == nNumInput


def GetBackTrack(arrInputPath):
    global objAdj
    global nTarget

    arrCurrPath = arrInputPath[-1]
    if len(arrInputPath) == nTarget:
        if CheckIsSqr(arrInputPath[-1] + arrInputPath[0]):
            return arrInputPath

        return []

    for objAdjLoop in objAdj[arrCurrPath]:
        if objAdjLoop in arrInputPath:
            continue

        arrInputPath.append(objAdjLoop)
        arrRes = GetBackTrack(arrInputPath)
        if arrRes:
            return arrRes

        arrInputPath.pop()

    return []


def GetSolveSqrCircle(nInput):
    global objAdj

    nMaxSum = 2 * nInput - 1
    arrSqr = [nInt * nInt for nInt in range(2, int(sqrt(nMaxSum)) + 1)]

    for nLoop in range(1, nInput + 1):
        for nSqrLoop in arrSqr:
            nRemain = nSqrLoop - nLoop

            if nRemain < 1:
                continue

            if nRemain > nInput:
                continue

            if nLoop == nRemain:
                continue

            objAdj[nLoop].append(nRemain)

    return GetBackTrack([1])


## nTarget = 32  ## Example 1
## nTarget = 15  ## Example 2
nTarget = 34  ## Example 3

objAdj = {nInt: [] for nInt in range(1, nTarget + 1)}

arrResult = GetSolveSqrCircle(nTarget)

print (arrResult)