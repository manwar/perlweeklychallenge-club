
from math import sqrt

IsPrime = (lambda nInt: not any(nInt % nDiv == 0 for nDiv in range(2, int(sqrt(nInt)) + 1)))

## strInput = "hello"  ## Example 1
## strInput = "football"  ## Example 2
## strInput = "a"  ## Example 3
## strInput = "challenge"  ## Example 4
strInput = "perl"  ## Example 5

nOrdSum = sum([ord(charLoop) for charLoop in list(strInput)])

## print (nOrdSum)

if IsPrime(nOrdSum):
    print (0)
else:
    nDiff = 1
    while True:
        if IsPrime(nOrdSum + nDiff):
            print (nDiff)
            break

        if nOrdSum <= nDiff:
            nDiff = nDiff + 1
            continue

        if IsPrime(nOrdSum - nDiff):
            print (nDiff)
            break

        nDiff = nDiff + 1
