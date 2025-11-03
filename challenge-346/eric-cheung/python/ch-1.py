
## strInput = "(()())"  ## Example 1
## strInput = ")()())"  ## Example 2
## strInput = "((()))()(((()"  ## Example 3
## strInput = "))))((()("  ## Example 4
strInput = "()(()"  ## Example 5

strTemp = strInput
nLastPosFind = len(strInput)
arrPos = []
nCount = 0

while (nPos := strTemp.find("()")) > -1:
    if nPos > nLastPosFind:
        arrPos.append(nCount)
        nCount = 0

    strTemp = strTemp[:nPos] + strTemp[nPos + 2:]
    nLastPosFind = nPos
    nCount = nCount + 2

arrPos.append(nCount)

print (max(arrPos))
