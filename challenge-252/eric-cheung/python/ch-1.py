
## arrInt = [1, 2, 3, 4]  ## Example 1
arrInt = [2, 7, 1, 19, 18, 3]  ## Example 2

arrOutput = [arrInt[nIndx] * arrInt[nIndx] for nIndx in range(len(arrInt)) if len(arrInt) % (nIndx + 1) == 0]
print (sum(arrOutput))
