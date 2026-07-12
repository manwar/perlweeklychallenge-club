def GetCountElements(arrNum):
    if len(arrNum) < 3:
        return 0

    nMinVal = min(arrNum)
    nMaxVal = max(arrNum)

    return len([nVal for nVal in arrNum if nMinVal < nVal and nVal < nMaxVal])


## arrInput = [2, 4]  ## Example 1
## arrInput = [1, 1, 1, 1]  ## Example 2
## arrInput = [1, 1, 4, 8, 12, 12]  ## Example 3
## arrInput = [3, 6, 6, 9]  ## Example 4
arrInput = [0, -5, 10, -2, 4]  ## Example 5

print (GetCountElements(arrInput))