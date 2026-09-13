## Ref.:
## https://leetcode.com/problems/decode-string/

## strInput = "2[3[a]]"  ## Example 1
## strInput = "10[a]"  ## Example 2
## strInput = "a2[b]c3[d]e"  ## Example 3
## strInput = "2[a2[b]c]"  ## Example 4
strInput = "1[a]2[b3[c]]"  ## Example 5

def GetDecodeStr(strFunc):
    arrTemp = []
    strOutput = ""
    nCurNum = 0

    for charLoop in strFunc:
        if charLoop.isdigit():
            nCurNum = nCurNum * 10 + int(charLoop)
        elif charLoop == "[":
            arrTemp.append((strOutput, nCurNum))
            strOutput = ""
            nCurNum = 0
        elif charLoop == "]":
            strPrev, nNum = arrTemp.pop()
            strOutput = strPrev + strOutput * nNum
        else:
            strOutput = strOutput + charLoop

    return strOutput

print (GetDecodeStr(strInput))