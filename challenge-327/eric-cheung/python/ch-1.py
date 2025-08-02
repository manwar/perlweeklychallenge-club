
## arrInts = [1, 2, 1, 3, 2, 5]  ## Example 1
## arrInts = [1, 1, 1]  ## Example 2
arrInts = [2, 2, 1]  ## Example 3

arrOutput = [nLoop for nLoop in range(1, len(arrInts) + 1) if not nLoop in arrInts]

print (arrOutput)
