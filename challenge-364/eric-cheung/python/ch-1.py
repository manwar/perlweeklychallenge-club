
## strInput = "10#11#12"  ## Example 1
## strInput = "1326#"  ## Example 2
## strInput = "25#24#123"  ## Example 3
## strInput = "20#5"  ## Example 4
strInput = "1910#26#"  ## Example 5

arrPosTag = []
for nIndx, charLoop in enumerate(strInput):
    if charLoop != "#":
        continue
    arrPosTag.extend([nIndx - 2, nIndx - 1])

if len(arrPosTag) > 0:
    nIndx = 0

    arrResult = []
    while nIndx < len(strInput):
        if nIndx in arrPosTag:
            arrResult.append(chr(int(strInput[nIndx:nIndx + 2]) + 96))
            nIndx = nIndx + 3
        else:
            arrResult.append(chr(int(strInput[nIndx]) + 96))
            nIndx = nIndx + 1

    strOutput = "".join(arrResult)
else:
    strOutput = "".join([chr(int(charLoop) + 96) for charLoop in strInput])

print (strOutput)
