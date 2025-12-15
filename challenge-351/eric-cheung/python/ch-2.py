
## arrNum = [1, 3, 5, 7, 9]  ## Example 1
## arrNum = [9, 1, 7, 5, 3]  ## Example 2
## arrNum = [1, 2, 4, 8, 16]  ## Example 3
## arrNum = [5, -1, 3, 1, -3]  ## Example 4
arrNum = [1.5, 3, 0, 4.5, 6]  ## Example 5

arrNum = sorted(arrNum)

dDiff = arrNum[1] - arrNum[0]

bIsAP = True
for nIndx in range(2, len(arrNum)):
    if arrNum[nIndx] - arrNum[nIndx - 1] != dDiff:
        bIsAP = False
        break

print (bIsAP)
