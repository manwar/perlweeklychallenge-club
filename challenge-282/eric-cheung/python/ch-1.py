
def GetGoodInteger (nFuncInput):
    strInput = str(nFuncInput)

    if len(strInput) < 3:
        return "-1"

    if len(strInput) == 3:
        return (strInput if len(set(strInput)) == 1 else "-1")

    for nIndx in range(len(strInput) - 3):

        bFirstFlag = (True if nIndx == 0 else len(set(strInput[nIndx - 1:nIndx + 3])) > 1)
        bLastFlag = (True if nIndx == len(strInput) - 2 else len(set(strInput[nIndx:nIndx + 4])) > 1)

        if bFirstFlag and len(set(strInput[nIndx:nIndx + 3])) == 1 and bLastFlag:
            return strInput[nIndx:nIndx + 3]

    return "-1"

## nInput = 12344456  ## Example 1
## nInput = 1233334  ## Example 2
nInput = 10020003  ## Example 3

print (GetGoodInteger(nInput))
