
## Ref.
## https://leetcode.com/problems/first-letter-to-appear-twice/description/
## https://medium.com/@ac.shreedhar/2351-first-letter-to-appear-twice-in-java-970f99e3f625
## https://algo.monster/liteproblems/2351

def GetFirstAppearTwice (strFunc):
    arrResult = [strFunc[0]]
    for nIndx in range(1, len(strFunc)):
        if strFunc[nIndx] in arrResult:
            return strFunc[nIndx]
        arrResult.append(strFunc[nIndx])
    return ""

## strInput = "acbddbca"  ## Example 1
## strInput = "abccd"  ## Example 2
strInput = "abcdabbb"  ## Example 3

print (GetFirstAppearTwice (strInput))
