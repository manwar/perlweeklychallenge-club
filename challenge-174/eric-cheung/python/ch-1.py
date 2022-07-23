
##

def IsDisariumNum (nInput):

    strInput = str(nInput)
    nCheckSum = 0

    for nIndex in range(0, len(strInput)):
        nCheckSum = nCheckSum + int(strInput[nIndex]) ** (nIndex + 1)

    if nCheckSum == nInput:
        return True

    return False


arrDisariumNum = []


nLoop = 0
while len(arrDisariumNum) < 19:

    if IsDisariumNum(nLoop):
        arrDisariumNum.append(nLoop)

    nLoop = nLoop + 1


print (arrDisariumNum)
## Result: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 89, 135, 175, 518, 598, 1306, 1676, 2427, 2646798]

