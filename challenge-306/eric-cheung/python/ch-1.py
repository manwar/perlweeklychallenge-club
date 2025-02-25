
arrInts = [2, 5, 3, 6, 4]  ## Example 1
## arrInts = [1, 3]  ## Example 2

## ===== METHOD 1 =====
## nSum = 0

## for nLen in range(1, len(arrInts) + 1, 2):
    ## ## print (nLen)

    ## for nPos in range(len(arrInts) + 1 - nLen):
        ## ## print (arrInts[nPos:nPos + nLen])
        ## nSum = nSum + sum(arrInts[nPos:nPos + nLen])

## print (nSum)
## ===== METHOD 1 =====

## ===== METHOD 2 =====
arrSum = [sum(arrInts[nPos:nPos + nLen]) for nLen in range(1, len(arrInts) + 1, 2) for nPos in range(len(arrInts) + 1 - nLen)]

print (sum(arrSum))
## ===== METHOD 2 =====
