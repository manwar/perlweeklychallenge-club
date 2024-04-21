
import re
import numpy as np

## Example 1
## strInput = "aBc 11c"
## arrStr = ["accbbb", "abc", "abbc"]

## Example 2
## strInput = "Da2 abc"
## arrStr = ["abcm", "baacd", "abaadc"]

## Example 3
strInput = "JB 007"
arrStr = ["jj", "bb", "bjb"]

strInputRev = re.sub("\d", "", strInput.lower().replace(" ", ""))
arrInputUniq = set([charLoop for charLoop in strInputRev])
arrInputCount = [strInputRev.count(charLoop) for charLoop in arrInputUniq]

arrOutput = []
for strLoop in arrStr:
    arrLoop = set([charLoop for charLoop in strLoop])
    
    arrCharNotMatch = [charLoop for charLoop in arrInputUniq if not charLoop in arrLoop]

    if len(arrCharNotMatch) > 0:
        continue

    bFlag = True
    for nIndx, charLoop in enumerate(arrInputUniq):
        if arrInputCount[nIndx] == 1:
            continue

        if strLoop.count(charLoop) < arrInputCount[nIndx]:
            bFlag = False
            break

    if bFlag:
        arrOutput.append(strLoop)

print (arrOutput[np.argmin([len(strLoop) for strLoop in arrOutput])] if len(arrOutput) > 0 else [])
