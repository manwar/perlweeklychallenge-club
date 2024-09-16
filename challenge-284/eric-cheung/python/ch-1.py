
## arrInts = [2, 2, 3, 4]  ## Example 1
## arrInts = [1, 2, 2, 3, 3, 3]  ## Example 2
arrInts = [1, 1, 1, 3]  ## Example 3

arrLucky = [nLoop for nLoop in set(arrInts) if arrInts.count(nLoop) == nLoop]

if len(arrLucky) == 0:
    print (-1)
else:
    print (max(arrLucky))
