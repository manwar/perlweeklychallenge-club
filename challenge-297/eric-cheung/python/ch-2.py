
def SwapElem (arrInput, nRowIndx, nColIndx):

    nTemp = arrInput[nRowIndx]
    arrInput[nRowIndx] = arrInput[nColIndx]
    arrInput[nColIndx] = nTemp

    return

def IsSemiOrderPerm (arrInput):

    return arrInput[0] == 1 and arrInput[-1] == len(arrInput)


## arrInt = [2, 1, 4, 3]  ## Example 1
## arrInt = [2, 4, 1, 3]  ## Example 2
arrInt = [1, 3, 2, 4, 5]  ## Example 3

nCount = 0
nLen = len(arrInt)

while not IsSemiOrderPerm (arrInt):

    nPos_1 = arrInt.index(1)

    if nPos_1 > 0:
        SwapElem (arrInt, nPos_1 - 1, nPos_1)
        nCount = nCount + 1

    if IsSemiOrderPerm (arrInt):
        break

    nPos_n = arrInt.index(nLen)

    if nPos_n < nLen - 1:
        SwapElem (arrInt, nPos_n, nPos_n + 1)
        nCount = nCount + 1

print (nCount)
