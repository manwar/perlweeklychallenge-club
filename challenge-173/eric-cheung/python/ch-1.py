

def IsEstheticNumber(nNum):

    strNum = str(nNum)
    for nLoop in range(0, len(strNum) - 1):
        ## print (strNum[nLoop] + " " + strNum[nLoop + 1])
        if abs(int(strNum[nLoop]) - int(strNum[nLoop + 1])) != 1:
            return False

    return True

## print (IsEstheticNumber(5456))
print (IsEstheticNumber(120))

