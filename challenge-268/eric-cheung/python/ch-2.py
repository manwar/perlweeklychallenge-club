
## arrInt = [2, 5, 3, 4]  ## Example 1
## arrInt = [9, 4, 1, 3, 6, 4, 6, 1]  ## Example 2
arrInt = [1, 2, 2, 3]  ## Example 3

arrInt = sorted(arrInt)
arrOutput = []

while len(arrInt) > 0:
    arrOutput.append(arrInt[1])
    arrOutput.append(arrInt[0])
    del arrInt[1]
    del arrInt[0]

print (arrOutput)
