
## Remarks
## https://github.com/doocs/leetcode/blob/main/solution/1300-1399/1380.Lucky%20Numbers%20in%20a%20Matrix/README_EN.md

## arrMatrix = [[3, 7, 8], [9, 11, 13], [15, 16, 17]]  ## Example 1
## arrMatrix = [[1, 10, 4, 2], [9, 3, 8, 7], [15, 16, 17, 12]]  ## Example 2
arrMatrix = [[7, 8], [1, 2]]  ## Example 3

setRowMin = {min(rowLoop) for rowLoop in arrMatrix}
setColMax = {max(colLoop) for colLoop in zip(*arrMatrix)}

arrLuckyNum = list(setRowMin & setColMax)  ## Intersection of Two Sets
print (arrLuckyNum if len(arrLuckyNum) > 0 else -1)
