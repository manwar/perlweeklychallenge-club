
## Ref.
## https://leetcode.com/problems/di-string-match/
## https://algo.monster/liteproblems/942

def GetDiStrMatch (strInput):

    arrOutput = []
    nLow, nHigh = 0, len(strInput)
    for charLoop in strInput:
        if charLoop == "I":
            arrOutput.append(nLow)
            nLow = nLow + 1
        else:
            arrOutput.append(nHigh)
            nHigh = nHigh - 1
    arrOutput.append(nLow)
    return arrOutput

## strExample = "IDID"  ## Example 1
## strExample = "III"  ## Example 2
strExample = "DDI"  ## Example 3

print (GetDiStrMatch(strExample))
