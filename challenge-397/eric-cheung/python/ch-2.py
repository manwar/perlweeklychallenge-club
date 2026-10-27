
## arrInput = [3, 6, 12]  ## Example 1
## arrInput = [1, 2, 4, 8]  ## Example 2
## arrInput = [7, 8, 9, 10]  ## Example 3
## arrInput = [5, 9, 15, 17]  ## Example 4
arrInput = [11, 13, 14, 19]  ## Example 5

arrBinRef = [[int("{0:b}".format(nElem)[::-1], 2), nElem] for nElem in arrInput]
arrSorted = sorted(arrBinRef, key = lambda nRow: (nRow[0], nRow[1]))
arrOutput = [arrLoop[1] for arrLoop in arrSorted]

print (arrOutput)
