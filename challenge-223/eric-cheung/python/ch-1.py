
## Remarks
## https://www.geeksforgeeks.org/print-all-prime-numbers-less-than-or-equal-to-n/

def IsPrime (nInput):
    if nInput <= 1:
        return False

    for nDivLoop in range(2, nInput):
        if nInput % nDivLoop == 0:
            return False

    return True

## nInt = 10  ## Example 1
## nInt = 1  ## Example 2
nInt = 20  ## Example 3

nPrimeCount = len([nLoop for nLoop in range(2, nInt + 1) if IsPrime(nLoop)])

print (nPrimeCount)
