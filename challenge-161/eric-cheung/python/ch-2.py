

def GetAscCode(strWord):

    arrCode = []

    for nSubLoop in range(0, len(strWord)):

        arrCode.append(ord(strWord[nSubLoop]) - 97)

    return arrCode

arrLetter = []

for nLoop in range(0, 26):

    arrLetter.append(0)

## print (arrLetter)
## print (GetAscCode("abc"))

strResult = ""

with open("Dictionary.txt") as objFile:

    for LineLoop in objFile:

        LineLoop = LineLoop.strip()

        ## print (LineLoop)
        arrTemp = GetAscCode(LineLoop)

        bNeedWord = False
        for codeLoop in arrTemp:
            if arrLetter[codeLoop] == 0:
                bNeedWord = True
                break

        if bNeedWord:

            if strResult:
                strResult = strResult + " "

            strResult = strResult + LineLoop

            for codeLoop in arrTemp:
                if arrLetter[codeLoop] == 0:
                    arrLetter[codeLoop] = 1

        bFinish = True
        for nLoop in range(0, 26):
            if arrLetter[nLoop] == 0:
                bFinish = False
                break

        if bFinish:
            break

print (strResult)

## Result
## a aardvark aback abacus abacuses abandon abandoning abandonment abbey abdominal abhor abject ablaze abrupt acknowledge acquaint adrift affix

