
def IsStrictly (arrFunc_01, bIncrease = True):
    for nIndx in range(1, len(arrFunc_01)):
        if bIncrease and arrFunc_01[nIndx - 1] >= arrFunc_01[nIndx] or not bIncrease and arrFunc_01[nIndx - 1] <= arrFunc_01[nIndx]:
            return False
    return True

def IsTrionic (arrFunc_02):
    for nP in range(1, len(arrFunc_02) - 2):
        for nQ in range(nP + 1, len(arrFunc_02) - 1):
            bIsStictly_01 = IsStrictly(arrFunc_02[:nP + 1])
            bIsStictly_02 = IsStrictly(arrFunc_02[nP:nQ + 1], False)
            bIsStictly_03 = IsStrictly(arrFunc_02[nQ:])

            if bIsStictly_01 and bIsStictly_02 and bIsStictly_03:
                return True

    return False

## arrGiven = [1, 3, 5, 4, 2, 6, 8]  ## Example 1
## arrGiven = [1, 4, 4, 2, 1, 3, 5]  ## Example 2
## arrGiven = [2, 10, 3, 1, 9]  ## Example 3
## arrGiven = [1, 2, 3, 4, 3, 2, 1]  ## Example 4
arrGiven = [1, 3, 6, 4, 2, 7, 8, 4]  ## Example 5

print (IsTrionic(arrGiven))
