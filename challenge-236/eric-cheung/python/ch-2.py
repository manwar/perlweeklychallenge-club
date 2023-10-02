
arrInput = [4, 6, 3, 8, 15, 0, 13, 18, 7, 16, 14, 19, 17, 5,  11,  1,  12,  2,  9,  10]  ## Example 1
## arrInput = [0, 1, 13, 7, 6, 8, 10, 11, 2, 14, 16, 4, 12, 9, 17, 5, 3, 18, 15, 19]  ## Example 2
## arrInput = [9, 8, 3, 11, 5, 7, 13, 19, 12, 4, 14, 10, 18, 2, 16, 1, 0, 15, 6, 17]  ## Example 3

arrIndx = [0] * len(arrInput)
arrOutput = []

for nIndxLoop in range(len(arrIndx)):
    if arrIndx[nIndxLoop] == 1:
        continue

    arrTemp = []
    nTempIndxLoop = nIndxLoop

    while arrInput[nTempIndxLoop] not in arrTemp:
        arrTemp.append(arrInput[nTempIndxLoop])
        arrIndx[nTempIndxLoop] = 1
        nTempIndxLoop = arrInput[nTempIndxLoop]

    arrOutput.append(arrTemp)

## print (arrOutput)
print (len(arrOutput))
