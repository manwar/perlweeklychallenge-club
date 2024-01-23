
def IsWeaker (rowA, rowB):
    return True if rowA.count(1) <= rowB.count(1) else False

## arrMatrix = [[1, 1, 0, 0, 0], [1, 1, 1, 1, 0], [1, 0, 0, 0, 0], [1, 1, 0, 0, 0], [1, 1, 1, 1, 1]]  ## Example 1
arrMatrix = [[1, 0, 0, 0], [1, 1, 1, 1], [1, 0, 0, 0], [1, 0, 0, 0]]  ## Example 2

arrIndx = [nIndx for nIndx in range(len(arrMatrix))]

for nRowLoop in range(len(arrIndx) - 1):
    for nColLoop in range(nRowLoop + 1, len(arrIndx)):
        if not IsWeaker (arrMatrix[arrIndx[nRowLoop]], arrMatrix[arrIndx[nColLoop]]):
            vTemp = arrIndx[nRowLoop]
            arrIndx[nRowLoop] = arrIndx[nColLoop]
            arrIndx[nColLoop] = vTemp

print (arrIndx)
