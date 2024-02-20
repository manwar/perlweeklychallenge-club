
## arrInt = [5, 2, 1, 6]  ## Example 1
## arrInt = [1, 2, 0, 3]  ## Example 2
## arrInt = [0, 1]  ## Example 3
arrInt = [9, 4, 9, 2]  ## Example 4

arrOutput = [len([arrInt[nColLoop] for nColLoop in range(len(arrInt)) if nColLoop != nRowLoop and arrInt[nColLoop] < arrInt[nRowLoop]]) for nRowLoop in range(len(arrInt))]

print (arrOutput)
