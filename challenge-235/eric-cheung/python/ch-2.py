
## arrInput = [1, 0, 2, 3, 0, 4, 5, 0]  ## Example 1
## arrInput = [1, 2, 3]  ## Example 2
arrInput = [0, 3, 0, 4, 5]  ## Example 3

arrTemp = arrInput[:]

for nIndx in range(len(arrInput) - 1, -1, -1):
    if arrTemp[nIndx] == 0:
        arrTemp.insert(nIndx, 0)

arrOutput = arrTemp[:len(arrInput)]

print (arrOutput)
