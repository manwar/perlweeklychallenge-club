
## Reference:
## https://www.javatpoint.com/python-program-to-check-if-the-given-number-is-happy-number

nDiv = 10

def GetDigitSumSq(strInput):
    nSum = 0
    for nDigit in range(0, len(strInput)):
        nSum = nSum + int(strInput[nDigit]) * int(strInput[nDigit])

    return nSum

def IsHappyNumber(nInput):
    if nInput == 1:
        return True
    elif nInput == 4:
        return False
    else:
        return IsHappyNumber(GetDigitSumSq(str(nInput)))

nLoop = 1
nCount = 0
arrHappyNum = []

while nCount < 8:
    if IsHappyNumber(nLoop):
        arrHappyNum.append(nLoop)
        nCount = nCount + 1
    
    nLoop = nLoop + 1

print (arrHappyNum)
