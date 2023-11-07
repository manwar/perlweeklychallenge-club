
arrMatrix = [[1, 1, 0], [0, 1, 1], [0, 0, 1]]  ## Example 0
## arrMatrix = [[1, 1, 0], [1, 0, 1], [0, 0, 0]]  ## Example 1
## arrMatrix = [[1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0]]  ## Example 2

arrOutput = []

for arrLoop in arrMatrix:
    arrOutput.append([1 - nLoop for nLoop in arrLoop[::-1]])

print (arrOutput)
