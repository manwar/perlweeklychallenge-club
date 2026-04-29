
from itertools import chain, combinations

def GetPowerSet(arrIterable):
    arrList = [[nElem, nIndx + 1] for nIndx, nElem in enumerate(arrIterable)]
    return chain.from_iterable(combinations(arrList, nIndx) for nIndx in range(2, len(arrList)))

## arrNum = [2, 1, 4, 3]  ## Example 1
## arrNum = [3, 0, 3, 0]  ## Example 2
## arrNum = [5, 1, 1, 1]  ## Example 3
## arrNum = [3, -1, 4, 2]  ## Example 4
arrNum = [10, 20, 30, 40]  ## Example 5

arrResult = list(GetPowerSet(arrNum))
arrOutput = []

for setLoop in arrResult:
    arrLoop = list(setLoop)

    arrElem = [arrSubLoop[0] for arrSubLoop in arrLoop]

    nSumElem = sum(arrElem)
    nSumIndx = sum([arrSubLoop[1] for arrSubLoop in arrLoop])
    
    ## print (arrLoop)

    if nSumElem != nSumIndx:
        continue

    arrOutput.append(arrElem)

print (arrOutput)
