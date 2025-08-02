
## nInput = 5  ## Example 1
## nInput = 3  ## Example 2
## nInput = 1  ## Example 3
nInput = 4  ## Example 4

nMax = int(nInput / 2 if nInput % 2 == 0 else (nInput - 1) / 2)
arrOutput = [nLoop for nLoop in range(-nMax, nMax + 1) if nLoop != 0 or nInput % 2 == 1]

print (arrOutput)
