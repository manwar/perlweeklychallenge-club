
## Example 1
## arrMatrix = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
## nShiftTime = 1

## Example 2
## arrMatrix = [[10, 20], [30, 40]]
## nShiftTime = 1

## Example 3
## arrMatrix = [[1, 2], [3, 4], [5, 6]]
## nShiftTime = 1

## Example 4
## arrMatrix = [[1, 2, 3], [4, 5, 6]]
## nShiftTime = 5

## Example 5
arrMatrix = [[1, 2, 3, 4]]
nShiftTime = 1

nNumRow = len(arrMatrix)
nNumCol = len(arrMatrix[0])

arrInitMatrix = arrMatrix[:][:]

## === Loop Shift Time ===
for nTimeLoop in range(nShiftTime):
    arrFinalMatrix = []

    ## === Rule 1 ===
    for nRowIndx in range(nNumRow):
        arrFinalMatrix.append(arrInitMatrix[nRowIndx][:-1])
    ## === Rule 1 ===

    ## === Rule 2 ===
    for nRowIndx in range(0, nNumRow - 1):
        arrFinalMatrix[nRowIndx + 1].insert(0, arrInitMatrix[nRowIndx][-1])
    ## === Rule 2 ===

    ## === Rule 3 ===
    arrFinalMatrix[0].insert(0, arrInitMatrix[-1][-1])
    ## === Rule 3 ===

    ## === Initial Back ===
    arrInitMatrix = arrFinalMatrix[:][:]
    ## === Initial Back ===
## === Loop Shift Time ===

print (arrFinalMatrix)
