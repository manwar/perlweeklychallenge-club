
## arrInputList = [2, 3, -1]  ## Example 1:
## arrInputList = [3, 2, -4]  ## Example 2:
arrInputList = [1, -1]  ## Example 3:

arrTempList = arrInputList[:]

while len(arrTempList) > 0:

    arrPosIndx = [nIndx for nIndx, nElemLoop in enumerate(arrTempList) if nElemLoop >= 0]
    if len(arrPosIndx) == 0 or len(arrPosIndx) == len(arrTempList):
        break

    arrNegIndx = [nIndx for nIndx, nElemLoop in enumerate(arrTempList) if nElemLoop < 0]
    nFirstNegIndx = arrNegIndx[0]

    if nFirstNegIndx == 0:
        break

    if arrTempList[nFirstNegIndx - 1] == abs(arrTempList[nFirstNegIndx]):
        del arrTempList[nFirstNegIndx]
        del arrTempList[nFirstNegIndx - 1]
    elif arrTempList[nFirstNegIndx - 1] < abs(arrTempList[nFirstNegIndx]):
        del arrTempList[nFirstNegIndx - 1]
    else:
        del arrTempList[nFirstNegIndx]

print (arrTempList)
