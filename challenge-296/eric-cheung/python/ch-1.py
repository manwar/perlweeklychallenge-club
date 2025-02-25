
def GetStrDecompress (strInput):

    arrCharSet = []
    for charLoop in strInput:
        if charLoop not in arrCharSet:
            arrCharSet.append(charLoop)

    strOutput = "".join([("" if strInput.count(charLoop) == 1 else str(strInput.count(charLoop))) + charLoop for charLoop in arrCharSet])

    return strOutput

## strChars = "abbc"  ## Example 1
## strChars = "aaabccc"  ## Example 2
strChars = "abcc"  ## Example 3

print (GetStrDecompress (strChars))
