
## nInputArr = [0, 1, 3]  ## Example 1
nInputArr = [0, 1]  ## Example 2

nFullArr = range(0, len(nInputArr) + 1)
nComplementArr = [nElemLoop for nElemLoop in nFullArr if nElemLoop not in nInputArr]

print (nComplementArr)
