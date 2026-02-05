
def GetSplitTxt (strInputTxt):
    if not strInputTxt:
        return False, ""

    arrSplit = []
    strTemp = strInputTxt[0]
    for nIndx in range(1, len(strInputTxt)):
        if strInputTxt[nIndx] == strTemp[0]:
            strTemp = strTemp + strInputTxt[nIndx]
        else:
            arrSplit.append(strTemp)
            strTemp = strInputTxt[nIndx]

    arrSplit.append(strTemp)

    strUniqTxt = "".join([strLoop for strLoop in arrSplit if len(strLoop) == 1])
    bIsDuplicate = (strInputTxt != strUniqTxt)

    return bIsDuplicate, strUniqTxt

## strWord = "aabbccdd"  ## Example 1
## strWord = "abccba"  ## Example 2
## strWord = "abcdef"  ## Example 3
## strWord = "aabbaeaccdd"  ## Example 4
strWord = "mississippi"  ## Example 5

bProceed = True
while bProceed:
    bProceed, strWord = GetSplitTxt (strWord)

print (strWord)
