
## Example 1
## nRow = 2
## nCol = 3
## arrLoc = [[0, 1], [1, 1]]

## Example 2
## nRow = 2
## nCol = 2
## arrLoc = [[1, 1], [0, 0]]

## Example 3
## nRow = 3
## nCol = 3
## arrLoc = [[0, 0], [1, 2], [2, 1]]

## Example 4
## nRow = 1
## nCol = 5
## arrLoc = [[0, 2], [0, 4]]

## Example 5
nRow = 4
nCol = 2
arrLoc = [[1, 0], [3, 1], [2, 0], [0, 1]]

arrList = [[0 for _ in range(nCol)] for _ in range(nRow)]

for arrLoop in arrLoc:
    nRowIndx = arrLoop[0]
    nColIndx = arrLoop[1]

    for nIndx in range(nCol):
        arrList[nRowIndx][nIndx] = arrList[nRowIndx][nIndx] + 1

    for nIndx in range(nRow):
        arrList[nIndx][nColIndx] = arrList[nIndx][nColIndx] + 1

nOddCount = sum([len([nElem for nElem in arrLoop if nElem % 2 == 1]) for arrLoop in arrList])

print (nOddCount)
