
## arrInt = [3, 4, 2]  ## Example 1
arrInt = [1, 2, 3]  ## Example 2

nCount = 0

while len(arrInt) > 0:
    if arrInt[0] > min(arrInt):
        arrInt.append(arrInt[0])
    del arrInt[0]
    nCount = nCount + 1

print (nCount)
