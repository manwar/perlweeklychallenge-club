
import math

arrCirPrime = []

def IsPrime(nInput):

    for nDiv in range(2, int(math.sqrt(nInput)) + 1):
        if nInput % nDiv == 0:
            return False

    return True


def IsCircularPrime(nNum):

    if not IsPrime(nNum):
        return False

    strNum = str(nNum)
    nLen = len(strNum)

    for nSubLoop in range(0, nLen):
        strNum = strNum[1:] + strNum[0]
        nVal = int(strNum)

        if not IsPrime(nVal):
            return False

        nExistCount = arrCirPrime.count(nVal)

        if nExistCount > 0:
            return False

    arrCirPrime.append(nNum)

    return True


nCount = 0
nLoop = 101

while nCount < 10:

    if IsCircularPrime(nLoop):
        print (str(nLoop))
        nCount = nCount + 1

    nLoop = nLoop + 1

