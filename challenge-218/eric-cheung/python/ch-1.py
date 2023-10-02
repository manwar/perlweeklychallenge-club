
## arrInputList = [3, 1, 2]  ## Example 1
## arrInputList = [4, 1, 3, 2]  ## Example 2
## arrInputList = [-1, 0, 1, 3, 1]  ## Example 3
arrInputList = [-8, 2, -9, 0, -4, 3]  ## Example 4

arrInterList = sorted(arrInputList)
arrNegInterList = [nElem for nElem in arrInterList if nElem < 0]

arrOutputList = []
if len(arrNegInterList) <= 1:
    arrOutputList = arrInterList[-3:]
else:
    nTempIndx = max(int((len(arrNegInterList) + (0 if len(arrNegInterList) % 2 == 0 else 1)) / 2), 2)

    for nElem in arrNegInterList[:nTempIndx]:
        arrOutputList.append(nElem)

    for nElem in arrInterList[-3 + len(arrOutputList):]:
        arrOutputList.append(nElem)

nProduct = 1
for nElem in arrOutputList:
    nProduct = nProduct * nElem

print (nProduct)
