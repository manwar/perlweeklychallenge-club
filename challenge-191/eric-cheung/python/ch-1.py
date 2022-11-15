
## arrInputList = [1, 2, 3, 4] ## Example 1
## arrInputList = [1, 2, 0, 5] ## Example 2
## arrInputList = [2, 6, 3, 1] ## Example 3
arrInputList = [4, 5, 2, 3] ## Example 4

arrInputList_Sort = list(set(arrInputList))
arrInputList_Sort.sort()

## print (arrInputList[-1])
## print (arrInputList[-2])

if arrInputList[-1] > 2 * arrInputList[-2]:
    print ("1")
else:
    print ("-1")
