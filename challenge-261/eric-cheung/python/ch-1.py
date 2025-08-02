
## arrInt = [1, 2, 3, 45]  ## Example 1
## arrInt = [1, 12, 3]  ## Example 2
## arrInt = [1, 2, 3, 4]  ## Example 3
arrInt = [236, 416, 336, 350]  ## Example 4

arrSplit = []
for nLoop in arrInt:
    arrSplit = arrSplit + [int(elem) for elem in str(nLoop)]

## print (sum(arrInt))
## print (sum(arrSplit))
print (abs(sum(arrInt) - sum(arrSplit)))
