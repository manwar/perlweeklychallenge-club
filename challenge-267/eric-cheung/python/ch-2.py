
## Example 1
## strInput = "abcdefghijklmnopqrstuvwxyz"
## arrCharWidth = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10]

## Example 2
strInput = "bbbcccdddaaa"
arrCharWidth = [4, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10]


nMaxUnitPerLine = 100

arrLineOutput = []
nLineUnitCount = 0
strLineAppend = ""

for charLoop in strInput:
    nIndx = ord(charLoop) - ord("a")
    if nLineUnitCount + arrCharWidth[nIndx] > nMaxUnitPerLine:
        arrLineOutput.append(strLineAppend)
        nLineUnitCount = 0
        strLineAppend = ""

    strLineAppend = strLineAppend + charLoop
    nLineUnitCount = nLineUnitCount + arrCharWidth[nIndx]

arrLineOutput.append(strLineAppend)

print ([len(arrLineOutput), nLineUnitCount])
