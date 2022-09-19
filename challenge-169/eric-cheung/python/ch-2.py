
## Remarks
## https://en.wikipedia.org/wiki/Achilles_number


import numpy as np
import math


def GetUniqueCount(arrList):
    arrObj = np.array(arrList)
    return np.unique(arrObj, return_counts = True)


def IsPrime(nInput):

    for nDiv in range(2, int(math.sqrt(nInput)) + 1):
        if nInput % nDiv == 0:
            return False

    return True


def PrimeFact(nOrigInput):

    nInput = nOrigInput
    arrPrimeFact = []

    if IsPrime(nInput):
        arrPrimeFact.append(nInput)
        return arrPrimeFact

    for nDiv in range(2, nOrigInput):

        while nInput % nDiv == 0 and nInput > 0:

            nInput = nInput / nDiv
            arrPrimeFact.append(nDiv)

        if nInput == 0:
            break

    return arrPrimeFact


def IsAchillesNum(nInput):

    ## print (nInput)

    arrPrime, arrCount = GetUniqueCount(PrimeFact(nInput))

    ## print (arrPrime)
    ## print (arrCount)

    ## Check Is Powerful
    if min(arrCount) == 1:
        return False

    ## Check Is Perfect
    if math.gcd(*arrCount) > 1:
        return False

    return True


## print (PrimeFact(37))
## print (IsAchillesNum(36))
## print (IsAchillesNum(72))
## print (IsAchillesNum(144))


nCount = 0
nLoop = 2

while nCount < 20:
    if IsAchillesNum(nLoop):
        print(nLoop)
        nCount = nCount + 1

    nLoop = nLoop + 1
