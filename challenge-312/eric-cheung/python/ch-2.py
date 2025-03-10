
## strInput = "G0B1R2R0B0"  ## Example 1
## strInput = "G1R3R6B3G6B1B6R1G3"  ## Example 2
strInput = "B3B2G1B3"  ## Example 3

arrColor = ["R", "G", "B"]
objBoxDict = {}
nCount = 0

setBox = set([int(strInput[nIndx]) for nIndx in range(1, len(strInput), 2)])
arrBoxLabel = [strInput[nIndx:nIndx + 2] for nIndx in range(0, len(strInput), 2)]

## print (setBox)
## print (arrBoxLabel)

for boxLoop in setBox:
    objBoxDict.update({boxLoop : [1 if arrBoxLabel.count(colorLoop + str(boxLoop)) > 0 else 0 for colorLoop in arrColor]})
    nCount = nCount + (1 if objBoxDict[boxLoop] == [1, 1, 1] else 0)

## print (objBoxDict)
print (nCount)
