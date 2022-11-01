
## arrInputList = [1, 3, 3, 2]  ## Example 1
## arrInputList = [1, 2, 1, 3]  ## Example 2
## arrInputList = [1, 3, 2, 1, 2]  ## Example 3
## arrInputList = [1, 1, 2, 3, 2]  ## Example 4
arrInputList = [2, 1, 2, 1, 1]  ## Example 5

arrUniqList = list(set(arrInputList))

arrOutput = []
arrSubOutput = []
arrMaxOutput = []
nMaxCount = 2

for nLoop in arrUniqList:

    if arrInputList.count(nLoop) > 1:
        arrItem = [nIndx for nIndx, nOrigLoop in enumerate(arrInputList) if nOrigLoop == nLoop]
        arrOutput.append([nLoop, arrInputList.count(nLoop), min(arrItem), max(arrItem)])

for arrLoop in arrOutput:

    if arrLoop[1] < nMaxCount:
        continue

    nMaxCount = arrLoop[1]
    arrSubOutput = arrInputList[arrLoop[2]:arrLoop[3] + 1]
    if len(arrMaxOutput) == 0 or len(arrSubOutput) < len(arrMaxOutput):
        arrMaxOutput = []
        arrMaxOutput = arrSubOutput

print (arrMaxOutput)
