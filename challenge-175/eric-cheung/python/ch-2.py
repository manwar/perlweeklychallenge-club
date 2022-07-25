
## Remark
## 

def getGCD (nNum_01, nNum_02):

    if (nNum_02 == 0):
        return abs(nNum_01)

    return getGCD(nNum_02, nNum_01 % nNum_02)


def getTotientNum (nInput):

    arrTotientNum = []

    for nLoop in range(1, nInput):
        if getGCD(nInput, nLoop) == 1:
            arrTotientNum.append(nLoop)

    return (len(arrTotientNum))


def IsPerfectTotientNum (nGivenNum):

    nSum = 0
    nInitNum = nGivenNum

    while getTotientNum(nInitNum) > 0:
        nSum = nSum + getTotientNum(nInitNum)
        nInitNum = getTotientNum(nInitNum)

    return (nSum == nGivenNum)


nNum = 3
arrPerfectTotientNum = []

while len(arrPerfectTotientNum) < 20:

    if IsPerfectTotientNum(nNum):
        arrPerfectTotientNum.append(nNum)

    nNum = nNum + 1

print (arrPerfectTotientNum)

## [3, 9, 15, 27, 39, 81, 111, 183, 243, 255, 327, 363, 471, 729, 2187, 2199, 3063, 4359, 4375, 5571]
