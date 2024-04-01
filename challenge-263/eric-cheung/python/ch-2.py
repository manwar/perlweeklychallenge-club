
## Example 1
## arrItem_01 = [[1, 1], [2, 1], [3, 2]]
## arrItem_02 = [[2, 2], [1, 3]]

## Example 2
## arrItem_01 = [[1, 2], [2, 3], [1, 3], [3, 2]]
## arrItem_02 = [[3, 1], [1, 3]]

## Example 3
arrItem_01 = [[1, 1], [2, 2], [3, 3]]
arrItem_02 = [[2, 3], [2, 4]]

arrCombine = arrItem_01 + arrItem_02
arrUniq = set([arrLoop[0] for arrLoop in arrCombine])
arrOutput = [[elemLoop, sum([arrLoop[1] for arrLoop in arrCombine if arrLoop[0] == elemLoop])] for elemLoop in arrUniq]

print (arrOutput)
