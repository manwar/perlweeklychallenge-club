
def IsStrNice (strFunc):
    arrFunc = set(list(strFunc))
    strChar = strFunc[0]
    return strChar.upper() in arrFunc and strChar.lower() in arrFunc

## strInput = "YaaAho"  ## Example 1
## strInput = "cC"  ## Example 2
strInput = "A"  ## Example 3

arrTemp = []
strTemp = strInput[0]

for charLoop in strInput[1:]:
    if charLoop.lower() == strTemp[-1].lower():
        strTemp = strTemp + charLoop
    else:
        arrTemp.append(strTemp)
        strTemp = charLoop

arrTemp.append(strTemp)

nMaxLen = 0
arrOutput = []

for strLoop in arrTemp:
    if not IsStrNice(strLoop):
        continue

    if len(strLoop) < nMaxLen:
        continue

    if len(strLoop) > nMaxLen:
        nMaxLen = len(strLoop)
        arrOutput = [strLoop]
    else:
        arrOutput.append(strLoop)

print (", ".join(arrOutput))
