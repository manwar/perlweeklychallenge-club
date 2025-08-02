
## strInput = "WeEeekly"  ## Example 1
## strInput = "abBAdD"  ## Example 2
strInput = "abc"  ## Example 3

bProceed = True
strTemp = strInput

while bProceed:
    bFound = False
    arrTemp = list(strTemp)
    for nIndx, charLoop in enumerate(arrTemp):
        if nIndx == 0:
            continue

        if charLoop.lower() == arrTemp[nIndx - 1].lower() and charLoop != arrTemp[nIndx - 1]:
            del arrTemp[nIndx]
            del arrTemp[nIndx - 1]
            bFound = True
            break

    strTemp = "".join(arrTemp)

    if bFound:
        continue

    bProceed = False

print (strTemp)
