
## arrNums = [4, 2, -1, 3, -2]  ## Example 1
## arrNums = [-5, 5, -3, 3, -1, 1]  ## Example 2
## arrNums = [7, -3, 0, 2, -8]  ## Example 3
## arrNums = [-2, -5, -1, -8]  ## Example 4
arrNums = [-2, 2, -4, 4, -1, 1]  ## Example 5

nDist = sorted([abs(nNum) for nNum in arrNums])

print (min(nDist))
