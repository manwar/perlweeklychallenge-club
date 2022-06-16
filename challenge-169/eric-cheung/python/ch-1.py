
## Remarks

import math

def PrimeFact(nInput):

    for nDiv in range(2, int(math.sqrt(nInput)) + 1):
        if nInput % nDiv == 0:
            return nDiv

    return 0


def IsBrillNum(nInput):

    nFact = PrimeFact(nInput)

    if nFact == 0:
        return False

    nFact_2 = int(nInput / nFact)

    nNum = PrimeFact(nFact_2)

    if nNum > 0:
        return False

    if len(str(nFact)) == len(str(nFact_2)):
        return True

    return False


## nOrigInputNum = 5
## print (IsBrillNum(nOrigInputNum))

nCount = 0
nLoop = 4

while nCount < 20:
    if IsBrillNum(nLoop):
        print(nLoop)
        nCount = nCount + 1

    nLoop = nLoop + 1
