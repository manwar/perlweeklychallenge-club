
def GetStrScore (strInput_Left, strInput_Right):
    return strInput_Left.count("0") + strInput_Right.count("1")

## strInput = "0011"  ## Example 1
## strInput = "0000"  ## Example 2
## strInput = "1111"  ## Example 3
## strInput = "0101"  ## Example 4
strInput = "011101"  ## Example 5

arrOutput = [GetStrScore(strInput[:nIndx], strInput[nIndx:]) for nIndx in range(1, len(strInput))]

print (max(arrOutput))
