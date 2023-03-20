
## arrNum = [1, 2, 2, 4]  ## Example 1
## arrNum = [1, 2, 3, 4]  ## Example 2
arrNum = [1, 2, 3, 3]  ## Example 3

arrList = range(1, len(arrNum) + 1)

arrDupMiss = list(set([nElemLoop for nElemLoop in arrNum if arrNum.count(nElemLoop) > 1])) + list(set(arrList).difference(set(arrNum)))

if len(arrDupMiss) > 0:
    print (arrDupMiss)
else:
    print (-1)
