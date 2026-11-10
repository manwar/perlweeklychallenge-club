
def GetCharReplace(strInput, nInput):
    nMaxLen = 0
    nMaxFreq = 0
    objCharCount = {}
    nLeft = 0

    for nRight, charLoop in enumerate(strInput):
        objCharCount[charLoop] = objCharCount.get(charLoop, 0) + 1

        nMaxFreq = max(nMaxFreq, objCharCount[charLoop])
        nCheck = nRight - nLeft + 1

        if nCheck - nMaxFreq > nInput:
            objCharCount[strInput[nLeft]] = objCharCount[strInput[nLeft]] - 1
            nLeft = nLeft + 1

        nMaxLen = max(nMaxLen, nCheck)
        
    return nMaxLen


## Example 1
## strGiven = "AAAAA"
## nK = 2

## Example 2
## strGiven = "ABCDE"
## nK = 4

## Example 3
## strGiven = "AAABBBBAA"
## nK = 1

## Example 4
## strGiven = "ABACADA"
## nK = 5

## Example 5
strGiven = "BAAABAAAA"
nK = 1

print (GetCharReplace(strGiven, nK))
