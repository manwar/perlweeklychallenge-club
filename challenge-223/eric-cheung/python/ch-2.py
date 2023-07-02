import math

def GetBoxCoin(arrInput):
    if len(arrInput) < 1:
        return 0
    if len(arrInput) == 1:
        return arrInput[0]

    nCount = 0
    for nIndx in range(len(arrInput)):
        arrTemp = arrInput[:]
        nTemp = math.prod(arrInput[max(nIndx - 1, 0):min(nIndx + 2, len(arrInput))])
        arrTemp.pop(nIndx)
        nCount = max(nCount, nTemp + GetBoxCoin(arrTemp))
    return nCount

arrBox = [3, 1, 5, 8]  ## Example 1
## arrBox = [1, 5]  ## Example 2

nTotalBoxCoin = GetBoxCoin(arrBox)

print ("Total: " + str(nTotalBoxCoin))
