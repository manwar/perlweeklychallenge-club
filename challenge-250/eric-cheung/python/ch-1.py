
## arrInt = [6, 12, 25, 1]  ## Example 1
## arrInt = [10, 7, 31, 5, 2, 2]  ## Example 2
arrInt = [1, 2, 10]  ## Example 3

nSum = 0
while len(arrInt) > 0:
    if len(arrInt) == 1:
        nSum = nSum + arrInt[0]
        del arrInt[0]
    else:
        nSum = nSum + int(str(arrInt[0]) + str(arrInt[-1]))
        del arrInt[-1]
        del arrInt[0]

print (nSum)

