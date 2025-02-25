
arrInts = [-3, 2, -3, 4, 2]  ## Example 1
## arrInts = [1, 2]  ## Example 2
## arrInts = [1, -2, -3]  ## Example 3

arrOutput = [1]

for nIndx in range(1, len(arrInts) + 1):
    arrOutput.append(1 - sum(arrInts[:nIndx]))

print (max(arrOutput))
