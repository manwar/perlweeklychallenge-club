
nKaprekarConst = 6174

## nInt = 3524  ## Example 1
## nInt = 6174  ## Example 2
## nInt = 9998  ## Example 3
## nInt = 1001  ## Example 4
## nInt = 9000  ## Example 5
nInt = 1111  ## Example 6

nCount = 0

while nInt != nKaprekarConst:
    if nInt == 0:
        nCount = -1
        break

    arrIntList = list("0" + str(nInt))[-4:]

    nBigger = int("".join(sorted(arrIntList, reverse = True)))
    nSmaller = int("".join(sorted(arrIntList)))

    nInt = nBigger - nSmaller

    nCount = nCount + 1

print (nCount)
