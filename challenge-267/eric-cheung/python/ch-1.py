
## arrInt = [-1, -2, -3, -4, 3, 2, 1]  ## Example 1
## arrInt = [1, 2, 0, -2, -1]  ## Example 2
arrInt = [-1, -1, 1, -1, 2]  ## Example 3

arrNegCount = [nLoop for nLoop in arrInt if nLoop < 0]

print (0 if 0 in arrInt else 1 if len(arrNegCount) % 2 == 0 else -1)
