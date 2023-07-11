
## arrInt = [10, 4, 8, 3]  ## Example 1
## arrInt = [1]  ## Example 2
arrInt = [1, 2, 3, 4, 5]  ## Example 3

arrLeft = [0]
arrRight = [0]

for nIndx in range(len(arrInt) - 1):
    arrLeft.append(arrLeft[-1] + arrInt[nIndx])
    arrRight.append(arrRight[-1] + arrInt[len(arrInt) - nIndx - 1])

arrRight.reverse()

arrLeftRightSumDiff = [abs(arrLeft[nIndx] - arrRight[nIndx]) for nIndx in range(len(arrLeft))]

## print (arrLeft)
## print (arrRight)
print (arrLeftRightSumDiff)
