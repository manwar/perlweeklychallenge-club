
## arrInts = [-3, -2, -1, 1, 2, 3]  ## Example 1
## arrInts = [-2, -1, 0, 0, 1]  ## Example 2
arrInts = [1, 2, 3, 4]  ## Example 3

nPosCount = len([nLoop for nLoop in arrInts if nLoop > 0])
nNegCount = len([nLoop for nLoop in arrInts if nLoop < 0])

print (max(nPosCount, nNegCount))
