
## arrInts = [55, 22, 44, 33]  ## Example 1
## arrInts = [10, 10, 10]  ## Example 2
arrInts = [5, 1, 1, 4, 3]  ## Example 3

arrSet = sorted(set(arrInts))

## print (arrSet)

arrOutput = [arrSet.index(nLoop) + 1 for nLoop in arrInts]

print (arrOutput)
