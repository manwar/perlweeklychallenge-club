
## arrMatrix = [[4, 4, 4, 4], [10, 0, 0, 0], [2, 2, 2, 9]]  ## Example 1
## arrMatrix = [[1, 5], [7, 3], [3, 5]]  ## Example 2
## arrMatrix = [[1, 2, 3], [3, 2, 1]]  ## Example 3
## arrMatrix = [[2, 8, 7], [7, 1, 3], [1, 9, 5]]  ## Example 4
arrMatrix = [[10, 20, 30], [5, 5, 5], [0, 100, 0], [25, 25, 25]]  ## Example 5

nHighestRowSum = max([sum(arrRowLoop) for arrRowLoop in arrMatrix])

print (nHighestRowSum)
