
from copy import deepcopy
import sys

def GetInfxFnd (nInputIndx, arrList, nInputNumCol):
    if nInputIndx + 1 in arrList and int(nInputIndx / nInputNumCol) == int((nInputIndx + 1) / nInputNumCol):
        return nInputIndx + 1
    
    if nInputIndx - 1 in arrList and int(nInputIndx / nInputNumCol) == int((nInputIndx - 1) / nInputNumCol):
        return nInputIndx - 1

    if nInputIndx + nInputNumCol in arrList:
        return nInputIndx + nInputNumCol

    if nInputIndx - nInputNumCol in arrList:
        return nInputIndx - nInputNumCol

    return -1

## Example 1
## arrChar = [["A", "B", "D", "E"], ["C", "B", "C", "A"], ["B", "A", "A", "D"], ["D", "B", "B", "C"]]
## strList = "BDCA"


## Example 2
## arrChar = [["A", "A", "B", "B"], ["C", "C", "B", "A"], ["C", "A", "A", "A"], ["B", "B", "B", "B"]]
## strList = "ABAC"


## Example 3
arrChar = [["B", "A", "B", "A"], ["C", "C", "C", "C"], ["A", "B", "A", "B"], ["B", "B", "A", "A"]]
strList = "CCCAA"


nNumRow = len(arrChar)
nNumCol = len(arrChar[0])

objCharDict = {}

for nRowLoop in range(nNumRow):
    for nColLoop in range(nNumCol):
        nIndxLoop = nRowLoop * nNumCol + nColLoop
        strCharLoop = arrChar[nRowLoop][nColLoop]

        if strCharLoop in objCharDict:
            objCharDict[strCharLoop].append(nIndxLoop)
        elif strCharLoop in strList:
            objCharDict.update({strCharLoop : [nIndxLoop]})

bFlag = True
for strLoop in set(strList):
    if strLoop not in objCharDict:
        bFlag = False
        break

    if strList.count(strLoop) > len(objCharDict[strLoop]):
        bFlag = False
        break

if not bFlag:
    print (bFlag)
    sys.exit()

bFound = False

for nIndxLoop in range(len(objCharDict[strList[0]])):
    objCharTempDict = deepcopy(objCharDict)

    nIndxFnd = objCharDict[strList[0]][nIndxLoop]
    bSucceed = True

    for nTempIndx in range(len(strList) - 1):
        objCharTempDict[strList[nTempIndx]].remove(nIndxFnd)
        nIndxFnd = GetInfxFnd (nIndxFnd, objCharTempDict[strList[nTempIndx + 1]], nNumCol)
        if nIndxFnd == -1:
            bSucceed = False
            break

    if bSucceed:
        bFound = True
        break

print (bFound)
