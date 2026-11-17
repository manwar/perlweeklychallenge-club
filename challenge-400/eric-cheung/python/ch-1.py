
## nGivenInt = 20  ## Example 1
## nGivenInt = 110  ## Example 2
## nGivenInt = 500  ## Example 3
## nGivenInt = 2026  ## Example 4
nGivenInt = 10000  ## Example 5

arrFilter = [nInt for nInt in range(1, nGivenInt + 1) if sorted(list(set(str(nInt)))) == sorted(list(str(nInt)))]

## print (arrFilter)

nMaxDiff = max([arrFilter[nIndx] - arrFilter[nIndx - 1] for nIndx in range(1, len(arrFilter))])

print (nMaxDiff)
