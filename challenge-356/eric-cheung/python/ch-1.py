
def GetKolakoskiSeq (nNumTrial):
    arrSeq = [1, 2, 2]
    arrNumToRepeat = [1, 2]

    nIndx = 2
    while nIndx <= nNumTrial - 1:
        nRunLen = arrSeq[nIndx]
        nRepeat = (1 if arrSeq[-1] == 2 else 2)
        arrSeq.extend([nRepeat] * nRunLen)
        arrNumToRepeat.append(nRepeat)
        nIndx = nIndx + 1

    return arrSeq, arrNumToRepeat

## nInput = 4  ## Example 1
## nInput = 5  ## Example 2
## nInput = 6  ## Example 3
## nInput = 7  ## Example 4
nInput = 8  ## Example 5

arrReqSeq, arrSeqRepeat = GetKolakoskiSeq(nInput)

print (arrSeqRepeat.count(1))
