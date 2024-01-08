
## Example 1
## strInput = "loveleetcode"
## strChar = "e"

## Example 2
strInput = "aaab"
strChar = "b"

arrCharIndx = [nIndx for nIndx in range(len(strInput)) if strInput[nIndx] == strChar]
arrOutput = []

for nIndx in range(len(strInput)):
    if strInput[nIndx] == strChar:
        arrOutput.append(0)
    elif nIndx < arrCharIndx[0]:
        arrOutput.append(arrCharIndx[0] - nIndx)
    else:
        arrOutput.append(min([abs(nLoop - nIndx) for nLoop in arrCharIndx]))

print (arrOutput)
