
## Ref.
## https://www.geeksforgeeks.org/coin-change-dp-7/

arrTypeCoin = ["HD", "Q", "D", "N", "P"]
arrCentsVal = [50, 25, 10, 5, 1]

## nAmount = 9  ## Example 1
## nAmount = 15  ## Example 2
nAmount = 100  ## Example 3

def GetCount(arrCoins, nCount, nSum):

    if (nSum < 0 or nCount <= 0):
        return 0

    if (nSum == 0):
        return 1

    ## GetCount is nSum of solutions
    ## (i) Excluding arrCoins[nCount - 1], Target Sum: nSum
    ## (ii) Including arrCoins[nCount - 1], Target Sum: nSum - arrCoins[nCount - 1]
    return GetCount(arrCoins, nCount - 1, nSum) + GetCount(arrCoins, nCount, nSum - arrCoins[nCount - 1])

## Main Program
print (GetCount(arrCentsVal, len(arrCentsVal), nAmount))
