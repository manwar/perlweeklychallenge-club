
## arrInt = [3, 3, 1]  ## Example 1
## arrInt = [3, 2, 4, 2, 4]  ## Example 2
## arrInt = [1]  ## Example 3
arrInt = [4, 3, 1, 1, 1, 4]  ## Example 4

arrUniq = [nLoop for nLoop in set(arrInt) if arrInt.count(nLoop) == 1]

print (arrUniq[0])
