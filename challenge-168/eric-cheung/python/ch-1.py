
## Remarks
## https://en.wikipedia.org/wiki/Perrin_number

import math

def IsPrime(nInput):

    for nDiv in range(2, int(math.sqrt(nInput)) + 1):
        if nInput % nDiv == 0:
            return False

    return True

arrPerrinPrime = []
arrPerrinNum = []

arrPerrinNum.append(3)
arrPerrinNum.append(0)
arrPerrinNum.append(2)

arrPerrinPrime.append(2)
arrPerrinPrime.append(3)

while len(arrPerrinPrime) < 13:
    nNuNum = arrPerrinNum[-2] + arrPerrinNum[-3]
    arrPerrinNum.append(nNuNum)

    if not IsPrime(nNuNum):
        continue

    nCount = arrPerrinPrime.count(nNuNum)

    if nCount > 0:
        continue

    arrPerrinPrime.append(nNuNum)

print (arrPerrinPrime)
