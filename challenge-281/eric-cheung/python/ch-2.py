
## Ref.
## https://www.geeksforgeeks.org/minimum-steps-reach-target-knight-set-2/

## Min Steps For A Knight to Reach Target Position

## Initialize the Matrix
arrKnightMove = [[0 for nRowLoop in range(8)] for nColLoop in range(8)]

## Size of Chess Board nBoardSize * nBoardSize
nBoardSize = 8

arrX_Coor = ["a", "b", "c", "d", "e", "f", "g", "h"]
arrY_Coor = [str(nLoop) for nLoop in range(1, 9)]

def GetStepMove (nStartPos_X, nStartPos_Y, nTargetPos_X, nTargetPos_Y):

    ## Exception
    ## These are the four corner points
    ## for which the minimum steps is 4

    if nStartPos_X == 1 and nStartPos_Y == 1 and nTargetPos_X == 2 and nTargetPos_Y == 2 or nStartPos_X == 2 and nStartPos_Y == 2 and nTargetPos_X == 1 and nTargetPos_Y == 1:
        return 4

    if nStartPos_X == 1 and nStartPos_Y == nBoardSize and nTargetPos_X == 2 and nTargetPos_Y == nBoardSize - 1 or nStartPos_X == 2 and nStartPos_Y == nBoardSize - 1 and nTargetPos_X == 1 and nTargetPos_Y == nBoardSize:
        return 4

    if nStartPos_X == nBoardSize and nStartPos_Y == 1 and nTargetPos_X == nBoardSize - 1 and nTargetPos_Y == 2 or nStartPos_X == nBoardSize - 1 and nStartPos_Y == 2 and nTargetPos_X == nBoardSize and nTargetPos_Y == 1:
        return 4

    if nStartPos_X == nBoardSize and nStartPos_Y == nBoardSize and nTargetPos_X == nBoardSize - 1 and nTargetPos_Y == nBoardSize - 1 or nStartPos_X == nBoardSize - 1 and nStartPos_Y == nBoardSize - 1 and nTargetPos_X == nBoardSize and nTargetPos_Y == nBoardSize:
        return 4

    ## If Knight is on the target, position return 0
    if nStartPos_X == nTargetPos_X and nStartPos_Y == nTargetPos_Y: 
        return arrKnightMove[0][0]

    ## If already calculated, then return that value. Take absolute difference
    nAbsDiff_X = abs(nStartPos_X - nTargetPos_X)
    nAbsDiff_Y = abs(nStartPos_Y - nTargetPos_Y)

    if arrKnightMove[nAbsDiff_X][nAbsDiff_Y] != 0:
        return arrKnightMove[nAbsDiff_X][nAbsDiff_Y]
  
    ## There will be two distinct positions
    ## from the knight towards a target
    ## if the target is in same row or column
    ## as of knight then there can be four
    ## positions towards the target but in that
    ## two would be the same and the other two
    ## would be the same.
    nInterPos_01_X, nInterPos_01_Y, nInterPos_02_X, nInterPos_02_Y = 0, 0, 0, 0

    ## (nInterPos_01_X, nInterPos_01_Y) and (nInterPos_02_X, nInterPos_02_Y) are two positions.
    ## these can be different according to situation.
    ## From position of knight, the chess board can be
    ## divided into four blocks i.e.. N-E, E-S, S-W, W-N
    if nStartPos_X <= nTargetPos_X:
        nInterPos_01_X = nStartPos_X + 2
        nInterPos_02_X = nStartPos_X + 1
    else:
        nInterPos_01_X = nStartPos_X - 2
        nInterPos_02_X = nStartPos_X - 1

    if nStartPos_Y <= nTargetPos_Y:
        nInterPos_01_Y = nStartPos_Y + 1
        nInterPos_02_Y = nStartPos_Y + 2
    else:
        nInterPos_01_Y = nStartPos_Y - 1
        nInterPos_02_Y = nStartPos_Y - 2

    ## Answer will be, 1 + minimum of steps 
    ## required from (nInterPos_01_X, nInterPos_01_Y) and (nInterPos_02_X, nInterPos_02_Y)
    arrKnightMove[nAbsDiff_X][nAbsDiff_Y] = min(GetStepMove(nInterPos_01_X, nInterPos_01_Y, nTargetPos_X, nTargetPos_Y), GetStepMove(nInterPos_02_X, nInterPos_02_Y, nTargetPos_X, nTargetPos_Y)) + 1

    ## exchanging the coordinates nStartPos_X with nStartPos_Y of both
    ## knight and target will result in same answer
    arrKnightMove[nAbsDiff_Y][nAbsDiff_X] = arrKnightMove[nAbsDiff_X][nAbsDiff_Y]

    return arrKnightMove[nAbsDiff_X][nAbsDiff_Y]


## Driver Code 
if __name__ == "__main__":

    ## (nStartPos_X, nStartPos_Y) coordinate of the Knight Position
    ## (nTargetPos_X, nTargetPos_Y) coordinate of the Target Position

    ## Example 1
    ## strStartPos = "g2"
    ## strTargetPos = "a8"

    ## Example 2
    strStartPos = "g2"
    strTargetPos = "h2"

    nStartPos_X = arrX_Coor.index(strStartPos[0]) + 1
    nStartPos_Y = arrY_Coor.index(strStartPos[1]) + 1

    nTargetPos_X = arrX_Coor.index(strTargetPos[0]) + 1
    nTargetPos_Y = arrY_Coor.index(strTargetPos[1]) + 1

    ## arrKnightMove[a][b], here a, b is the difference of
    ## nStartPos_X & nTargetPos_X and nStartPos_Y & nTargetPos_Y respectively
    arrKnightMove[1][0] = 3
    arrKnightMove[0][1] = 3
    arrKnightMove[1][1] = 2
    arrKnightMove[2][0] = 2
    arrKnightMove[0][2] = 2
    arrKnightMove[2][1] = 1
    arrKnightMove[1][2] = 1

    print (GetStepMove(nStartPos_X, nStartPos_Y, nTargetPos_X, nTargetPos_Y))
