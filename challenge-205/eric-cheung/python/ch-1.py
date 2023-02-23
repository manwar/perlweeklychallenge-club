
## arrInputList = [5, 3, 4]  ## Example 1
## arrInputList = [5, 6]  ## Example 2
arrInputList = [5, 4, 4, 3]  ## Example 3

arrOutputList = list(set(arrInputList))

if len(arrOutputList) >= 3:
    print (arrOutputList[-3])
else:
    print (arrOutputList[-1])
