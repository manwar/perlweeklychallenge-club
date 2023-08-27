
## arrInt = [3, 2, 1, 4]  ## Example 1
## arrInt = [3, 1]  ## Example 2
arrInt = [2, 1, 3]  ## Example 3

arrOutput = [nLoop for nLoop in arrInt if nLoop != min(arrInt) and nLoop != max(arrInt)]

print (-1 if len(arrOutput) == 0 else arrOutput)
