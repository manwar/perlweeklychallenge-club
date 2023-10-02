
## arrInt = [2, 1, 3, 2]  ## Example 1
## arrInt = [1, 1, 1, 1]  ## Example 2
arrInt = [2, 1, 3, 4]  ## Example 3

arrUniqInt = [nLoop for nLoop in list(set(arrInt)) if arrInt.count(nLoop) == 1]

print (sum(arrUniqInt))
