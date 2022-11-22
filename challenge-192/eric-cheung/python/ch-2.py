
import sys
import numpy as np

def IsEqui(arrCheck):
    if arrCheck[0] == arrCheck[1] and arrCheck[1] == arrCheck[2]:
        return True

    return False

def GetMove(arrMove, nFromIndx, nToIndx, nMoveNum):
    arrMove[nFromIndx] = arrMove[nFromIndx] - 1
    arrMove[nToIndx] = arrMove[nToIndx] + 1

    print ("Move #" + str(nMoveNum) + ": " + ", ".join([str(nLoop) for nLoop in arrMove]))

arrInputList = [1, 0, 5]  ## Example 1
## arrInputList = [0, 2, 0]  ## Example 2
## arrInputList = [0, 3, 0]  ## Example 3

if sum(arrInputList) % 3 != 0:
    print (-1)
    sys.exit()

arrTempList = [nLoop for nLoop in arrInputList]
nCountStep = 0

while not IsEqui(arrTempList):

    nArgMaxIndx = np.argmax(arrTempList)
    nCountStep = nCountStep + 1

    if nArgMaxIndx == 0:
        if arrTempList[1] > arrTempList[2]:
            GetMove(arrTempList, 1, 2, nCountStep)
        else:
            GetMove(arrTempList, 0, 1, nCountStep)
    elif nArgMaxIndx == 1:
        if arrTempList[0] > arrTempList[2]:
            GetMove(arrTempList, 1, 2, nCountStep)
        else:
            GetMove(arrTempList, 1, 0, nCountStep)
    elif nArgMaxIndx == 2:
        if arrTempList[0] >= arrTempList[1]:
            GetMove(arrTempList, 2, 1, nCountStep)
        else:
            GetMove(arrTempList, 1, 0, nCountStep)

print (nCountStep)
