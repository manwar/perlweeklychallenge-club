
## Remarks
## https://en.wikipedia.org/wiki/Home_prime

import math

def IsPrime(nInput):

    for nDiv in range(2, int(math.sqrt(nInput)) + 1):
        if nInput % nDiv == 0:
            return False

    return True


def PrimeFact(nOrigInput):

    nInput = nOrigInput
    arrPrimeFact = []

    for nDiv in range(2, nOrigInput):

        while nInput % nDiv == 0 and nInput > 0:

            nInput = nInput / nDiv
            arrPrimeFact.append(nDiv)

        if nInput == 0:
            break

    return arrPrimeFact


def ConcatArray(arrInput):

    strResult = ""

    for arrElem in arrInput:
        strResult = strResult + str(arrElem)

    return int(strResult)


## print (PrimeFact(511))
## print (ConcatArray(PrimeFact(511)))
## print (ConcatArray(PrimeFact(8)))


nOrigInputNum = 10

nInputNum = nOrigInputNum

while not IsPrime(nInputNum):
    nInputNum = ConcatArray(PrimeFact(nInputNum))

print ("HP(" + str(nOrigInputNum) + ") = " + str(nInputNum))

