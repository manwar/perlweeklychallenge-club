
## strInput = "a"  ## Example 1
## strInput = "aB2"  ## Example 2
## strInput = "PaaSW0rd"  ## Example 3
## strInput = "Paaasw0rd"  ## Example 4
strInput = "aaaaa"  ## Example 5

nDupChar = 3

nLenCharAdd = (0 if len(strInput) >= 6 else 6 - len(strInput))

nLenUpperAdd = (0 if any(strLoop.isupper() for strLoop in strInput) else 1)
nLenLowerAdd = (0 if any(strLoop.islower() for strLoop in strInput) else 1)
nIsNumericAdd = (0 if any(strLoop.isnumeric() for strLoop in strInput) else 1)

nCharSumAdd = sum([nLenUpperAdd, nLenLowerAdd, nIsNumericAdd])

## ==
arrList = list(strInput)
arrUniqList = set(arrList)
arrDupList = [charLoop for charLoop in set(arrList) if arrList.count(charLoop) >= 3]

arrCheckList = []
arrSubCheckList = []
arrCheckIndx = []
for nIndx, charLoop in enumerate(arrList):
    if charLoop not in arrDupList:
        continue

    if len(arrSubCheckList) == 0:
        arrSubCheckList.append([charLoop, [nIndx]])
    elif arrSubCheckList[-1][0] == charLoop and nIndx - arrSubCheckList[-1][1][-1] == 1:
        arrSubCheckList[-1][1].append(nIndx)
    else:
        arrCheckList = arrCheckList + arrSubCheckList
        arrSubCheckList = []
        arrSubCheckList.append([charLoop, [nIndx]])

if len(arrSubCheckList) > 0:
    arrCheckList = arrCheckList + arrSubCheckList
    arrSubCheckList = []

for arrLoop in arrCheckList:
    if len(arrLoop[1]) < nDupChar:
        continue

    for nSubIndx in range(nDupChar - 1, len(arrLoop[1]), nDupChar):
        arrCheckIndx.append(nSubIndx)

nLenChange = len(arrCheckIndx)
## ==

nTemp = (nCharSumAdd - nLenCharAdd if nCharSumAdd >= nLenCharAdd else 0)
nTemp = (nTemp - nLenChange if nTemp >= nLenChange else 0)

nTotalSteps = nLenCharAdd + nLenChange + nTemp

print (nTotalSteps)
