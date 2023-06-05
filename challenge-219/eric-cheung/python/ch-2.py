
## Example 1
## arrCost = [2, 7, 25]
## arrDays = [1, 5, 6, 7, 9, 15]

## Example 2
arrCost = [2, 7, 25]
arrDays = [1, 2, 3, 5, 7, 10, 11, 12, 14, 20, 30, 31]

## Trial 1
nCost = arrCost[2]

## Trial 2
nCost = min(nCost, arrCost[0] * len(arrDays))

## Trial 3
nLoop = 0
nWeekCount = 0
while nLoop < len(arrDays):
    nLoopDay = arrDays[nLoop] + 6

    ## print ("nLoop: " + str(nLoop))
    ## print ("nLoopDay: " + str(nLoopDay))

    arrSubDay = [nIndx for nIndx, nElem in enumerate(arrDays) if nElem >= nLoopDay]

    if arrSubDay == []:
        nWeekCount = nWeekCount + 1
        break

    nFindIndx = min(arrSubDay)
    nShiftIndx = (1 if arrDays[nFindIndx] == nLoopDay else 0)
    nLoop = nShiftIndx + nFindIndx
    nWeekCount = nWeekCount + 1

    ## print ("nWeekCount: " + str(nWeekCount))
    ## print ("")


## print (nWeekCount)
nCost = min(nCost, arrCost[1] * nWeekCount)

## Trial 4
nLoop = 1
nIndx = 0
while nLoop < nWeekCount:
    nLoopDay = arrDays[nIndx] + 6
    arrSubDay = [nIndx for nIndx, nElem in enumerate(arrDays) if nElem >= nLoopDay]

    if arrSubDay == []:
        break

    nFindIndx = min(arrSubDay)
    nShiftIndx = (1 if arrDays[nFindIndx] == nLoopDay else 0)
    nIndx = nShiftIndx + nFindIndx
    nRemain = len(arrSubDay) - nShiftIndx
    nCost = min(nCost, arrCost[1] * nLoop + arrCost[0] * nRemain)
    nLoop = nLoop + 1

print (nCost)
