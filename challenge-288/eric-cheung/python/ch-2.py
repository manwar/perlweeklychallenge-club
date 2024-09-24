
def GetDivQuot (nNum, nDiv):
    return int(nNum / nDiv)

## arrMatrix = [["x", "x", "x", "x", "o"], ["x", "o", "o", "o", "o"], ["x", "o", "o", "o", "o"], ["x", "x", "x", "o", "o"]]  ## Example 1

## arrMatrix = [["x", "x", "x", "x", "x"], ["x", "o", "o", "o", "o"], ["x", "x", "x", "x", "o"], ["x", "o", "o", "o", "o"]]  ## Example 2

arrMatrix = [["x", "x", "x", "o", "o"], ["o", "o", "o", "x", "x"], ["o", "x", "x", "o", "o"], ["o", "o", "o", "x", "x"]]  ## Example 3

arrPosMatrix_X = []
arrPosMatrix_O = []

nNumRow = len(arrMatrix)
nNumCol = len(arrMatrix[0])

for nRowLoop in range(nNumRow):
    for nColLoop in range(nNumCol):
        nIndx = nRowLoop * nNumCol + nColLoop
        if arrMatrix[nRowLoop][nColLoop] == "x":
            arrPosMatrix_X.append(nIndx)
        else:
            arrPosMatrix_O.append(nIndx)

## print (arrPosMatrix_X)
## print (arrPosMatrix_O)

arrBlock_X = []
arrBlock_Sub_X = []
for nLoop in arrPosMatrix_X:
    if len(arrBlock_Sub_X) > 0 and not (int((nLoop - 1) / nNumCol) == int(nLoop / nNumCol) and nLoop - 1 in arrBlock_Sub_X) and nLoop - nNumCol not in arrBlock_Sub_X:
        arrBlock_X.append(arrBlock_Sub_X)
        arrBlock_Sub_X = []

    arrBlock_Sub_X.append(nLoop)

if len(arrBlock_Sub_X) > 0:
    arrBlock_X.append(arrBlock_Sub_X)

for nIndxLoop in range(len(arrBlock_X) - 1, 0, -1):
    for nElem in arrBlock_X[nIndxLoop]:
        bIsFound = False
        for nIndxSubLoop in range(nIndxLoop):
            if nElem - nNumCol in arrBlock_X[nIndxSubLoop]:
                bIsFound = True
                arrBlock_X[nIndxSubLoop] = arrBlock_X[nIndxSubLoop] + arrBlock_X[nIndxLoop]
                break

        if bIsFound:
            del arrBlock_X[nIndxLoop]
            break

## print (arrBlock_X)

arrBlock_O = []
arrBlock_Sub_O = []
for nLoop in arrPosMatrix_O:
    if len(arrBlock_Sub_O) > 0 and not (GetDivQuot(nLoop - 1, nNumCol) == GetDivQuot(nLoop, nNumCol) and nLoop - 1 in arrBlock_Sub_O) and nLoop - nNumCol not in arrBlock_Sub_O:
        arrBlock_O.append(arrBlock_Sub_O)
        arrBlock_Sub_O = []

    arrBlock_Sub_O.append(nLoop)

if len(arrBlock_Sub_O) > 0:
    arrBlock_O.append(arrBlock_Sub_O)

for nIndxLoop in range(len(arrBlock_O) - 1, 0, -1):
    for nElem in arrBlock_O[nIndxLoop]:
        bIsFound = False
        for nIndxSubLoop in range(nIndxLoop):
            if nElem - nNumCol in arrBlock_O[nIndxSubLoop]:
                bIsFound = True
                arrBlock_O[nIndxSubLoop] = arrBlock_O[nIndxSubLoop] + arrBlock_O[nIndxLoop]
                break

        if bIsFound:
            del arrBlock_O[nIndxLoop]
            break

## print (arrBlock_O)

arrOutput = []
for arrLoop in arrBlock_X:
    arrOutput.append(len(arrLoop))

for arrLoop in arrBlock_O:
    arrOutput.append(len(arrLoop))

print (max(arrOutput))
