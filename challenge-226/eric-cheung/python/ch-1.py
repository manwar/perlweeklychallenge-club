
## Example 1
## strInput = "lacelengh"
## arrIndices = [3, 2, 0, 5, 4, 8, 6, 7, 1]

## Example 2
strInput = "rulepark"
arrIndices = [4, 7, 3, 1, 0, 5, 2, 6]

strOutput = "".join([strInput[arrIndices.index(nLoop)] for nLoop in range(len(strInput))])

print (strOutput)
