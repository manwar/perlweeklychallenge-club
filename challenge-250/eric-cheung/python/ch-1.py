
## arrInt = [0, 1, 2]  ## Example 1
## arrInt = [4, 3, 2, 1]  ## Example 2
arrInt = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]  ## Example 3

arrOutput = [nIndx for nIndx in range(len(arrInt)) if nIndx % 10 == arrInt[nIndx]]
if len(arrOutput) > 0:
    print (arrOutput[0])
else:
    print (-1)
