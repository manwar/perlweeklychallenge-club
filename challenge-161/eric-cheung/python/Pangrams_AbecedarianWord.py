

def IsAbecedarianWord(strWord):

    for nSubLoop in range(0, len(strWord) - 1):
        if strWord[nSubLoop] > strWord[nSubLoop + 1]:
            return False

    return True


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

        if not IsAbecedarianWord(LineLoop):
            continue

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
## a abbey abbot abhor abhors ably accent accept ad affix aglow aim buy buzz envy jot knot qt

