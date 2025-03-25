
## arrList = ["swpc", "tyad", "azbe"]  ## Example 1
## arrList = ["cba", "daf", "ghi"]  ## Example 2
arrList = ["a", "b", "c"]  ## Example 3

arrMatrix = list(zip(*[[charLoop for charLoop in arrList[nRow]] for nRow in range(len(arrList))]))

## print (arrMatrix)

arrResult = [arrList for arrList in arrMatrix if sorted(list(arrList)) != list(arrList)]

print (len(arrResult))
