
import numpy as np

def GetManDist(arrValidInputPnt, arrCurPnt):
    return abs(arrValidInputPnt[0] - arrCurPnt[0]) + abs(arrValidInputPnt[1] - arrCurPnt[1])

## Example 1
## nX = 3
## nY = 4
## arrPnts = [[1, 2], [3, 1], [2, 4], [2, 3]]

## Example 2
## nX = 2
## nY = 5
## arrPnts = [[3, 4], [2, 3], [1, 5], [2, 5]]

## Example 3
## nX = 1
## nY = 1
## arrPnts = [[2, 2], [3, 3], [4, 4]]

## Example 4
## nX = 0
## nY = 0
## arrPnts = [[0, 1], [1, 0], [0, 2], [2, 0]]

## Example 5
nX = 5
nY = 5
arrPnts = [[5, 6], [6, 5], [5, 4], [4, 5]]

objValidPnts = {nIndx : arrPntLoop for nIndx, arrPntLoop in enumerate(arrPnts) if arrPntLoop[0] == nX or arrPntLoop[1] == nY}

if len(objValidPnts) > 0:
    nMinIndx = np.argmin([GetManDist(objValidPnts[nIndxKey], [nX, nY]) for nIndxKey in objValidPnts])
    print ([nIndxKey for nIndx, nIndxKey in enumerate(objValidPnts) if nIndx == nMinIndx][0])
else:
    print (-1)
