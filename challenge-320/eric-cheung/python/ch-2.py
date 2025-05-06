
## arrInts = [1, 23, 4, 5]  ## Example 1
## arrInts = [1, 2, 3, 4, 5]  ## Example 2
arrInts = [1, 2, 34]  ## Example 3

nElemSum = sum(arrInts)
nDigitSum = sum([sum([int(charLoop) for charLoop in list(str(nLoop))]) for nLoop in arrInts])

## print (nElemSum)
## print (nDigitSum)

print (abs(nElemSum - nDigitSum))
