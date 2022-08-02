
def IsReversible(nInput):
    strSum = str(nInput + int(str(nInput)[::-1]))

    for nLoop in range(0, len(strSum)):
        if int(strSum[nLoop]) % 2 == 0:
            return False

    return True


arrReversible = []

nLoop = 1

while nLoop < 100:
    if IsReversible(nLoop):
        arrReversible.append(nLoop)

    nLoop = nLoop + 1

print (arrReversible)
## Result: [10, 12, 14, 16, 18, 21, 23, 25, 27, 30, 32, 34, 36, 41, 43, 45, 50, 52, 54, 61, 63, 70, 72, 81, 90]
