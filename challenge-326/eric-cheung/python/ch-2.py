
## arrInt = [1, 3, 2, 4]  ## Example 1
## arrInt = [1, 1, 2, 2]  ## Example 2
arrInt = [3, 1, 3, 2]  ## Example 3

arrOutput = []

for nIndx in range(1, len(arrInt), 2):
    arrOutput = arrOutput + [arrInt[nIndx]] * arrInt[nIndx - 1]

print (arrOutput)
