## arrMatrix = [[1, 2, 3, 4], [2, 3, 4, 1], [3, 4, 1, 2], [4, 1, 2, 3]]  ## Example 1
## arrMatrix = [[1]]  ## Example 2
## arrMatrix = [[1, 2, 5], [5, 1, 2], [2, 5, 1]]  ## Example 3
## arrMatrix = [[1, 2, 3], [1, 2, 3], [1, 2, 3]]  ## Example 4
arrMatrix = [[1, 2, 3], [3, 1, 2], [3, 2, 1]]  ## Example 5

nLen = len(arrMatrix)

arrList = [nInt for nInt in range(1, nLen + 1)]

arrMatrixTransp = [list(arrRow) for arrRow in zip(*arrMatrix)]

arrRowFlag = [arrRow for arrRow in arrMatrix if set(arrRow) != set(arrList)]
arrColFlag = [arrCol for arrCol in arrMatrixTransp if set(arrCol) != set(arrList)]

print (len(arrRowFlag) == 0 and len(arrColFlag) == 0)