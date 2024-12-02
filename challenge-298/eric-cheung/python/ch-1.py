
import itertools

def IsOneMatrix (arrInput):
    nRowInput = len(arrInput)
    nColInput = len(arrInput[0])

    for nRow, nCol in itertools.product(range(nRowInput), range(nColInput)):
        if arrInput[nRow][nCol] == 0:
            return False

    return True

## arrMatrix = [[1, 0, 1, 0, 0], [1, 0, 1, 1, 1], [1, 1, 1, 1, 1], [1, 0, 0, 1, 0]]  ## Example 1
## arrMatrix = [[0, 1], [1, 0]]  ## Example 2
arrMatrix = [[0]]  ## Example 3

nNumRow = len(arrMatrix)
nNumCol = len(arrMatrix[0])

nArea = 0

for nRowPos, nColPos in itertools.product(range(nNumRow), range(nNumCol)):
    for nRowLoop, nColLoop in itertools.product(range(nRowPos, nNumRow), range(nColPos, nNumCol)):

        if nRowLoop - nRowPos != nColLoop - nColPos:
            continue

        arrSubMatrix = arrMatrix[nRowPos : nRowLoop + 1][:]
        arrSubMatrix = [list(arrLoop) for arrLoop in zip(*arrSubMatrix)][nColPos : nColLoop + 1][:]
        arrSubMatrix = [list(arrLoop) for arrLoop in zip(*arrSubMatrix)][:][:]

        ## print ("")
        ## print ("====")
        ## print (nRowPos, nRowLoop, nColPos, nColLoop)
        ## print (arrSubMatrix)
        ## print ("====")

        if not IsOneMatrix (arrSubMatrix):
            continue

        if (nRowLoop - nRowPos + 1) * (nColLoop - nColPos + 1) <= nArea:
            continue

        nArea = (nRowLoop - nRowPos + 1) * (nColLoop - nColPos + 1)

print (nArea)