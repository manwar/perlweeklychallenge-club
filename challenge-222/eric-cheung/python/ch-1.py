
## arrInput = [1, 1, 4, 2, 1, 3]  ## Example 1
## arrInput = [5, 1, 2, 3, 4]  ## Example 2
arrInput = [1, 2, 3, 4, 5]  ## Example 3

arrSort = sorted(arrInput)
nCount = 0

for nLoop in range(0, len(arrInput)):
    if arrInput[nLoop] == arrSort[nLoop]:
        nCount = nCount + 1

print (nCount)
