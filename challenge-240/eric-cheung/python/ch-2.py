
## arrInput = [0, 2, 1, 5, 3, 4]  ## Example 1
arrInput = [5, 0, 1, 2, 3, 4]  ## Example 2

arrOutput = [arrInput[arrInput[nIndx]] for nIndx in range(len(arrInput))]

print (arrOutput)
