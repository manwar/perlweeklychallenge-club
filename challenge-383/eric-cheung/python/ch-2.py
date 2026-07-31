
arrColorList = {"00" : 0, "33" : 51, "66" : 102, "99" : 153, "CC" : 204, "FF" : 255}

## strColorInput = "#F4B2D1"  ## Example 1
## strColorInput = "#15E6E5"  ## Example 2
## strColorInput = "#191A65"  ## Example 3
## strColorInput = "#2D5A1B"  ## Example 4
strColorInput = "#00FF66"  ## Example 5

arrColorOutput = []
for nIndx in range(1, len(strColorInput) - 1, 2):
    strNearColorKey, nNearColorVal = min(arrColorList.items(), key = lambda item: abs(item[1] - int(strColorInput[nIndx:nIndx + 2], 16)))
    arrColorOutput.append(strNearColorKey)

strColorOutput = "#" + "".join(arrColorOutput)

print (strColorOutput)
