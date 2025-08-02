
## strInput = "a1c1e1"  ## Example 1
## strInput = "a1b2c3d4"  ## Example 2
## strInput = "b2b"  ## Example 3
strInput = "a16z"  ## Example 4

arrList = list(strInput)
arrPosNum = [nIndx for nIndx, charLoop in enumerate(strInput) if charLoop.isdigit()]
arrPosChar = [nIndx for nIndx, charLoop in enumerate(strInput) if charLoop.isalpha()]

## print (arrPosNum)
## print (arrPosChar)

for nIndx in arrPosNum:
    LastChar = strInput[[nLoop for nLoop in arrPosChar if nLoop < nIndx][-1]]
    arrList[nIndx] = chr(ord(LastChar) + int(arrList[nIndx]))

print ("".join(arrList))
