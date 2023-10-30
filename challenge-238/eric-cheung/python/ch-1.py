
## arrInput = [1, 2, 3, 4, 5]  ## Example 1
## arrInput = [1, 1, 1, 1, 1]  ## Example 2
arrInput = [0, -1, 1, 2]  ## Example 3

arrOutput = []
for nLoop in arrInput:
    ## print (nLoop)
    arrOutput.append(nLoop if len(arrOutput) == 0 else nLoop + arrOutput[-1])
    ## print (arrOutput)

print (arrOutput)
