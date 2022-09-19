
## Remarks
## https://www.educative.io/answers/what-are-permuted-multiples

def Calculate(nNumInput, nTimes):

    nResult = nNumInput * nTimes
    nTempArr = []

    for i in range(0, len(str(nResult))):
        nTempArr.append(int(str(nResult)[i]))

    nTempArr.sort()
    strTempArr = [str(i) for i in nTempArr]

    return "".join(strTempArr)


def Find_Number():

    nNumLoop = 1
    nMultiple = 6

    while (True):

        arrList = []
        
        for nLoop in range(1, nMultiple + 1):
            arrList.append(Calculate(nNumLoop, nLoop))
        
        bFlag = True
        
        for nLoop in range(0, len(arrList) - 1):
            if arrList[nLoop] != arrList[nLoop + 1]:
                bFlag = False
                nNumLoop = nNumLoop + 1
                break

        if bFlag:
            print(nNumLoop)
            return

Find_Number()
## Result: 142857
