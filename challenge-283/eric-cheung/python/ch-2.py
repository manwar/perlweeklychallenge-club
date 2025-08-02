
## arrInt = [1, 2, 1, 0]  ## Example 1
arrInt = [0, 3, 0]  ## Example 2

arrOutput = [nLoop for nIndx, nLoop in enumerate(arrInt) if arrInt.count(nIndx) == nLoop]

print (len(arrInt) == len(arrOutput))
