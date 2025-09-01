
## arrNum = [6, 5, 4, 8]  ## Example 1
## arrNum = [7, 7, 7, 7]  ## Example 2
## arrNum = [5, 4, 3, 2, 1]  ## Example 3
## arrNum = [-1, 0, 3, -2, 1]  ## Example 4
arrNum = [0, 1, 1, 2, 0]  ## Example 5

arrOutput = [len([nSubElem for nSubElem in arrNum if nElem > nSubElem]) for nElem in arrNum]

print (arrOutput)
