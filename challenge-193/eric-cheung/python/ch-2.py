
def GetDiffStr(strInput):
    return ",".join([str(ord(strInput[nIndx]) - ord(strInput[nIndx - 1])) for nIndx in range(1, len(strInput))])

## arrInputStr = ["adc", "wzy", "abc"]  ## Example 1
arrInputStr = ["aaa", "bob", "ccc", "ddd"]  ## Example 2

arrStrAppend = []
strOdd = ""

for strLoop in arrInputStr:
    arrStrAppend.append(GetDiffStr(strLoop))

for nIndxLoop, strLoop in enumerate(arrStrAppend):
    if arrStrAppend.count(strLoop) == 1:
        strOdd = arrInputStr[nIndxLoop]
        break

print (strOdd)
