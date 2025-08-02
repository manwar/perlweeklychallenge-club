
def IsSimilarDomino (arrDomino_01, arrDomino_02):
    return arrDomino_01[0] == arrDomino_02[0] and arrDomino_01[1] == arrDomino_02[1] or arrDomino_01[0] == arrDomino_02[1] and arrDomino_01[1] == arrDomino_02[0]

arrDominos = [[1, 3], [3, 1], [2, 4], [6, 8]]  ## Example 1
## arrDominos = [[1, 2], [2, 1], [1, 1], [1, 2], [2, 2]]  ## Example 2

arrDominosIndxResult = []
for nRowLoop in range(len(arrDominos) - 1):
    for nColLoop in range(nRowLoop + 1, len(arrDominos)):
        if IsSimilarDomino (arrDominos[nRowLoop], arrDominos[nColLoop]):
            if nRowLoop not in arrDominosIndxResult:
                arrDominosIndxResult.append(nRowLoop)
            if nColLoop not in arrDominosIndxResult:
                arrDominosIndxResult.append(nColLoop)

## print (arrDominosIndxResult)
print (len(arrDominosIndxResult))
