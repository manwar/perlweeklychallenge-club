
## Example 1
## arrParty = [
    ## [0, 0, 0, 0, 1, 0]
    ## , [0, 0, 0, 0, 1, 0]
    ## , [0, 0, 0, 0, 1, 0]
    ## , [0, 0, 0, 0, 1, 0]
    ## , [0, 0, 0, 0, 0, 0]
    ## , [0, 0, 0, 0, 1, 0]
## ]

## Example 2
## arrParty = [
    ## [0, 1, 0, 0]
    ## , [0, 0, 1, 0]
    ## , [0, 0, 0, 1]
    ## , [1, 0, 0, 0]
## ]

## Example 3
## arrParty = [
    ## [0, 0, 0, 0, 0]
    ## , [1, 0, 0, 0, 0]
    ## , [1, 0, 0, 0, 0]
    ## , [1, 0, 0, 0, 0]
    ## , [1, 0, 0, 0, 0]
## ]

## Example 4
## arrParty = [
    ## [0, 1, 0, 1, 0, 1]
    ## , [1, 0, 1, 1, 0, 0]
    ## , [0, 0, 0, 1, 1, 0]
    ## , [0, 0, 0, 0, 0, 0]
    ## , [0, 1, 0, 1, 0, 0]
    ## , [1, 0, 1, 1, 0, 0]
## ]

## Example 5
## arrParty = [
    ## [0, 1, 1, 0]
    ## , [1, 0, 1, 0]
    ## , [0, 0, 0, 0]
    ## , [0, 0, 0, 0]
## ]

## Example 6
arrParty = [
    [0, 0, 1, 1]
    , [1, 0, 0, 0]
    , [1, 1, 0, 1]
    , [1, 1, 0, 0]
]

arrKnow = []
arrPosCelebrity = []

for nRowIndx, arrRow in enumerate (arrParty):
    arrTemp = [nIndx for nIndx, nElem in enumerate (arrRow) if nElem == 1]
    arrKnow.append(arrTemp)
    if len(arrTemp) == 0:
        arrPosCelebrity.append(nRowIndx)

arrFlag = []
for nCelebrity in arrPosCelebrity:
    nFlag = True
    for nIndx, arrKnowLoop in enumerate (arrKnow):
        if nIndx == nCelebrity and len(arrKnowLoop) > 0:
            nFlag = False
            break
        elif nIndx != nCelebrity and not nCelebrity in arrKnowLoop:
            nFlag = False
            break

    arrFlag.append(nFlag)

arrResult = [nCelebrity for nCelebrity, bFlag in zip (arrPosCelebrity, arrFlag) if bFlag]

print (arrResult if len(arrResult) > 0 else -1)
