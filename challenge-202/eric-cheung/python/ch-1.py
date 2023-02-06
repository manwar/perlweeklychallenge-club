
def IsConsecOdds(arrSubInput):
    arrSubInput.sort()

    for nIndx in range(0, len(arrSubInput) - 3 + 1):
        if arrSubInput[nIndx] % 2 == 1 and arrSubInput[nIndx + 1] - arrSubInput[nIndx] == 2 and arrSubInput[nIndx + 2] - arrSubInput[nIndx + 1] == 2:
            return 1

    return 0

## arrInput = [1, 5, 3, 6]  ## Example 1
## arrInput = [2, 6, 3, 5]  ## Example 2
## arrInput = [1, 2, 3, 4]  ## Example 3
arrInput = [2, 3, 5, 7]  ## Example 4

print (IsConsecOdds(arrInput))
