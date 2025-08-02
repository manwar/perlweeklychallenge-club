
## arrInt = [-3, 1, 2, -1, 3, -2, 4]  ## Example 1
## arrInt = [-1, -2, -3, 1]  ## Example 2
arrInt = [1, 2]  ## Example 3

arrPos = [nElem for nElem in arrInt if nElem > 0]
arrNeg = [nElem for nElem in arrInt if nElem < 0]

print (max(len(arrPos), len(arrNeg)))
