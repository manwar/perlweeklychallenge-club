
## arrInts = [3, 8, 5, 2, 9, 2]  ## Example 1
arrInts = [3, 2, 5]  ## Example 2

while len(arrInts) > 1:
    arrInts = sorted(arrInts)
    
    nY = arrInts[-1]
    nX = arrInts[-2]

    del arrInts[-2]
    del arrInts[-1]

    if nY > nX:
        arrInts.append(nY - nX)

print (0 if len(arrInts) == 0 else arrInts[0])

