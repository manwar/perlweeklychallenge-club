
## arrInt = [5, 6, 4, 1]  ## Example 1
## arrInt = [4, 5]  ## Example 2
arrInt = [1, 2, 2, 3]  ## Example 3

arrOutput = sorted(set(arrInt), reverse = True)

## print (arrOutput)

if len(arrOutput) >= 3:
    print (arrOutput[2])
else:
    print (arrOutput[0])