
arrInputList = [2, 5, 8, 1]  ## Example 1
## arrInputList = [3]  ## Example 2

arrInputList.sort()
arrDiff = [arrInputList[nIndx + 1] - arrInputList[nIndx] for nIndx in range(0, len(arrInputList) - 1)]

if len(arrDiff) > 0:
    nMaxArrDiff = max(arrDiff)
    print (arrDiff.count(nMaxArrDiff))
else:
    print (0)
