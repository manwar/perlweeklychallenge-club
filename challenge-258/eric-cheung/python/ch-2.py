
## Example 1
## arrInt = [2, 5, 9, 11, 3]
## nInput = 1

## Example 2
## arrInt = [2, 5, 9, 11, 3]
## nInput = 2

## Example 3
arrInt = [2, 5, 9, 11, 3]
nInput = 0

arrOutput = [elemLoop for nIndx, elemLoop in enumerate(arrInt) if bin(nIndx)[2:].count("1") == nInput]
print (sum(arrOutput))
