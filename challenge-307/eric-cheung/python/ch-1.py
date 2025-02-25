
## arrInts = [5, 2, 4, 3, 1]  ## Example 1
## arrInts = [1, 2, 1, 1, 3]  ## Example 2
arrInts = [3, 1, 3, 2, 3]  ## Example 3

arrSorted = sorted(arrInts)

arrOutput = [nIndx for nIndx, (nOrig, nSort) in enumerate(zip(arrInts, arrSorted)) if nOrig != nSort]

print (arrOutput)
