
## arrInt = [4, 1, 2, 3]  ## Example 1
## arrInt = [3, 1]  ## Example 2
arrInt = [5, 3, 2, 1, 4]  ## Example 3

arrOdd = sorted([arrInt[nIndx] for nIndx in range(1, len(arrInt), 2)], reverse = True)
arrEven = sorted([arrInt[nIndx] for nIndx in range(0, len(arrInt), 2)], reverse = False)

arrOutput = [arrEven[int(nIndx / 2)] if nIndx % 2 == 0 else arrOdd[int((nIndx - 1) / 2)] for nIndx in range(len(arrInt))]

print (arrOutput)
