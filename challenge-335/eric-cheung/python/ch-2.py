
def PlayerWin(arrInput, nNumMove):
    for nRow in range(3):
        if len(set([arrInput[nRow][nCol] for nCol in range(3)])) == 1 and arrInput[nRow][nRow] in ["A", "B"]:
            return arrInput[nRow][nRow]

    for nCol in range(3):
        if len(set([arrInput[nRow][nCol] for nRow in range(3)])) == 1 and arrInput[nCol][nCol] in ["A", "B"]:
            return arrInput[nCol][nCol]

    if len(set([arrInput[nMax][nMax] for nMax in range(3)])) == 1 and arrInput[1][1] in ["A", "B"]:
        return arrInput[1][1]

    if len(set([arrInput[nMax][2 - nMax] for nMax in range(3)])) == 1 and arrInput[1][1] in ["A", "B"]:
        return arrInput[1][1]

    return ("Draw" if nNumMove == 9 else "Pending")

## arrMoves = [[0, 0], [2, 0], [1, 1], [2, 1], [2, 2]]  ## Example 1
## arrMoves = [[0, 0], [1, 1], [0, 1], [0, 2], [1, 0], [2, 0]]  ## Example 2
## arrMoves = [[0, 0], [1, 1], [2, 0], [1, 0], [1, 2], [2, 1], [0, 1], [0, 2], [2, 2]]  ## Example 3
## arrMoves = [[0, 0], [1, 1]]  ## Example 4
arrMoves = [[1, 1], [0, 0], [2, 2], [0, 1], [1, 0], [0, 2]]  ## Example 5

arrOutput = [["_", "_", "_"], ["_", "_", "_"], ["_", "_", "_"]]

for nIndx, arrLoop in enumerate(arrMoves):
    arrOutput[arrLoop[0]][arrLoop[1]] = ("A" if nIndx % 2 == 0 else "B")

## print (arrOutput)
print (PlayerWin(arrOutput, len(arrMoves)))
