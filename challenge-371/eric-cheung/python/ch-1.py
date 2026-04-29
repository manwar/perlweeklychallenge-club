
## arrSeq = ["a", "c", "?", "g", "i"]  ## Example 1
## arrSeq = ["a", "d", "?", "j", "m"]  ## Example 2
## arrSeq = ["a", "e", "?", "m", "q"]  ## Example 3
## arrSeq = ["a", "c", "f", "?", "k"]  ## Example 4
arrSeq = ["b", "e", "g", "?", "l"]  ## Example 5

nQuesIndx = arrSeq.index("?")

## print (nQuesIndx)

arrStep = []
for nIndx in range(4):
    if not nQuesIndx in [nIndx, nIndx + 1]:
        arrStep.append(ord(arrSeq[nIndx + 1]) - ord(arrSeq[nIndx]))

## print (arrStep)

if len(set(arrStep)) == 1:
    nStep = arrStep[0]
    if nQuesIndx == 0:
        print (chr(ord(arrSeq[1]) - nStep))
    else:
        print (chr(ord(arrSeq[nQuesIndx - 1]) + nStep))
else:
    if nQuesIndx == 0:
        nStep = arrStep[1]
        print (chr(ord(arrSeq[1]) - nStep))
    elif nQuesIndx == 1:
        nStep = arrStep[1]
        print (chr(ord(arrSeq[2]) - nStep))
    elif nQuesIndx == 2:
        nStep = arrStep[1]
        print (chr(ord(arrSeq[1]) + nStep))
    elif nQuesIndx == 3:
        nStep = arrStep[0]
        print (chr(ord(arrSeq[2]) + nStep))
    else:
        nStep = arrStep[1]
        print (chr(ord(arrSeq[3]) + nStep))
