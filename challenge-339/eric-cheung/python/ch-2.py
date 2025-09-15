
## arrGain = [-5, 1, 5, -9, 2]  ## Example 1
## arrGain = [10, 10, 10, -25]  ## Example 2
## arrGain = [3, -4, 2, 5, -6, 1]  ## Example 3
## arrGain = [-1, -2, -3, -4]  ## Example 4
arrGain = [-10, 15, 5]  ## Example 5

arrOutput = [0]
arrOutput = arrOutput + [sum(arrGain[:nIndx + 1]) for nIndx in range(len(arrGain))]

print (max(arrOutput))
