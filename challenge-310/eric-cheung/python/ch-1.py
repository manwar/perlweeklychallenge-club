
import sys

## arrList = [[1, 2, 3, 4], [4, 5, 6, 1], [4, 2, 1, 3]]  ## Example 1
## arrList = [[1, 0, 2, 3], [2, 4, 5]]  ## Example 2
arrList = [[1, 2, 3], [4, 5], [6]]  ## Example 3

if len(arrList) == 1:
    print (arrList[0])
    sys.exit()

arrOutput = []

for nElem in arrList[0]:
    bFlag = True
    for arrLoop in arrList[1:]:
        if not nElem in arrLoop:
            bFlag = False
            break
    if bFlag:
        arrOutput.append(nElem)

print (arrOutput)
