
## Ref.
## https://leetcode.com/problems/jump-game/description/?tab=Description
## https://www.geeksforgeeks.org/minimum-number-of-jumps-to-reach-end-of-a-given-array/

def GetMinJumps(arrInput, nLower, nUpper):
    dInf = float("inf")

    if nUpper == nLower:
        return 0

    if arrInput[nLower] == 0:
        return dInf

    nMinStep = dInf
    for nLoop in range(nLower + 1, nUpper + 1):
        if nLoop >= nLower + arrInput[nLower] + 1:
            continue

        nJumpStep = GetMinJumps(arrInput, nLoop, nUpper)

        if nJumpStep == dInf:
            continue

        if nJumpStep + 1 >= nMinStep:
            continue

        nMinStep = nJumpStep + 1

    return (-1 if nMinStep == dInf else nMinStep)


## arrInt = [2, 3, 1, 1, 4]  ## Example 1
## arrInt = [2, 3, 0, 4]  ## Example 2
arrInt = [2, 0, 0, 4]  ## Example 3

print (GetMinJumps(arrInt, 0, len(arrInt) - 1))
