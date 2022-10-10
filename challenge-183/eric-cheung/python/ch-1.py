
## arrList = [[1,2], [3,4], [5,6], [1,2]]  ## Example 1
arrList = [[9,1], [3,7], [2,5], [2,5]]  ## Example 2

arrUniqList = []

for nLoop in range(0, len(arrList)):
    if not arrList[nLoop] in arrUniqList:
        arrUniqList.append(arrList[nLoop])

print (arrUniqList)
