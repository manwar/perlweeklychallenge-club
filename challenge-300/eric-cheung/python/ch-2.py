
## arrInts = [5, 4, 0, 3, 1, 6, 2]  ## Example 1
arrInts = [0, 1, 2]  ## Example 2

nMaxLen = 0

for nIndx in range(len(arrInts)):
    arrSet = [arrInts[nIndx]]

    while arrInts[arrSet[-1]] not in arrSet:
        arrSet.append(arrInts[arrSet[-1]])

    if len(arrSet) > nMaxLen:
        nMaxLen = len(arrSet)

print (nMaxLen)
