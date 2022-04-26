
nMaxElem = 25
nDiv = 5
arrKey = []

def getKeyTable(strWord):
    nCount = 0
    
    for nLoop in range(0, len(strWord)):
        strLetter = strWord[nLoop].upper()

        if strLetter == " ":
            continue
        
        if not strLetter in arrKey:
            arrKey.append(strLetter)
            nCount = nCount + 1

    nIndex = 65
    nLoop = nCount
    while nLoop < nMaxElem:
        strLetter = chr(nIndex)

        if strLetter == "I" or strLetter == "J":
            if not "I" in arrKey and not "J" in arrKey:
                arrKey.append(strLetter)
                nLoop = nLoop + 1
        elif not strLetter in arrKey:
            arrKey.append(strLetter)
            nLoop = nLoop + 1

        nIndex = nIndex + 1

def getRowColFromKey(strChar):

    nIndx = -1
    if strChar == "I" or strChar == "J":
        if "I" in arrKey:
            nIndx = arrKey.index("I")
        else:
            nIndx = arrKey.index("J")
    else:
        nIndx = arrKey.index(strChar)

    nRowIndx = int (nIndx / nDiv)
    nColIndx = nIndx % nDiv

    return [nRowIndx, nColIndx]


def getRefineNewMsg(strWord, bIsEncrypt):

    strNuWord = ""
    for nLoop in range(0, len(strWord)):
        strLetter = strWord[nLoop].upper()

        if strLetter == " ":
            continue

        if nLoop == 0:
            strNuWord = strLetter
        elif strLetter == strWord[nLoop - 1].upper():
            if bIsEncrypt:
                strNuWord = strNuWord + "X" + strLetter
            else:
                strNuWord = strNuWord + strLetter
        else:
            strNuWord = strNuWord + strLetter

    return strNuWord

def getEncryptDecryptPair(strLetterPair, bIsEncrypt):

    nRowNum_01, nColNum_01 = getRowColFromKey(strLetterPair[0])
    nRowNum_02, nColNum_02 = getRowColFromKey(strLetterPair[1])

    if nRowNum_01 == nRowNum_02 and nColNum_01 == nColNum_02:

        return strLetterPair

    if nRowNum_01 != nRowNum_02 and nColNum_01 != nColNum_02:

        nMinCol = min(nColNum_01, nColNum_02)
        nMaxCol = max(nColNum_01, nColNum_02)
        
        nRowNum_Nu_01 = nRowNum_01
        nRowNum_Nu_02 = nRowNum_02

        nColNum_Nu_01 = nMaxCol - nColNum_01 + nMinCol
        nColNum_Nu_02 = nMaxCol - nColNum_02 + nMinCol
        
    elif nRowNum_01 == nRowNum_02:
        
        nColDiff = 1
        
        nRowNum_Nu_01 = nRowNum_01
        nRowNum_Nu_02 = nRowNum_02
        
        if bIsEncrypt:
            nColNum_Nu_01 = nColNum_01 + nColDiff if nColNum_01 + nColDiff < nDiv else nColNum_01 + nColDiff - nDiv
            nColNum_Nu_02 = nColNum_02 + nColDiff if nColNum_02 + nColDiff < nDiv else nColNum_02 + nColDiff - nDiv
        else:
            nColNum_Nu_01 = nColNum_01 - nColDiff if nColNum_01 - nColDiff > -1 else nColNum_01 - nColDiff + nDiv
            nColNum_Nu_02 = nColNum_02 - nColDiff if nColNum_02 - nColDiff > -1 else nColNum_02 - nColDiff + nDiv
    else:

        nRowDiff = 1

        if bIsEncrypt:
            nRowNum_Nu_01 = nRowNum_01 + nRowDiff if nRowNum_01 + nRowDiff < nDiv else nRowNum_01 + nRowDiff - nDiv
            nRowNum_Nu_02 = nRowNum_02 + nRowDiff if nRowNum_02 + nRowDiff < nDiv else nRowNum_02 + nRowDiff - nDiv
        else:
            nRowNum_Nu_01 = nRowNum_01 - nRowDiff if nRowNum_01 - nRowDiff > -1 else nRowNum_01 - nRowDiff + nDiv
            nRowNum_Nu_02 = nRowNum_02 - nRowDiff if nRowNum_02 - nRowDiff > -1 else nRowNum_02 - nRowDiff + nDiv

        nColNum_Nu_01 = nColNum_01
        nColNum_Nu_02 = nColNum_02

    return arrKey[nRowNum_Nu_01 * nDiv + nColNum_Nu_01] + arrKey[nRowNum_Nu_02 * nDiv + nColNum_Nu_02]


def getEncryptDecrytMsg(strWord, bIsEncrypt):

    strEncryWord = ""
    for nLoop in range(0, len(strWord)):
        if nLoop % 2 == 1:
            continue

        ## print (strWord[nLoop:nLoop + 2] + "-" + getEncryptDecryptPair(strWord[nLoop:nLoop + 2], bIsEncrypt))
        strEncryWord = strEncryWord + getEncryptDecryptPair(strWord[nLoop:nLoop + 2], bIsEncrypt)

    return strEncryWord.lower()


def EncryptDecryptPart(strKeyWord, strEncryptWord, bIsEncrypt):

    getKeyTable(strKeyWord)

    return getEncryptDecrytMsg(getRefineNewMsg(strEncryptWord, bIsEncrypt), bIsEncrypt)

## print (EncryptDecryptPart("playfair example", "hide the gold in the tree stump", True))
print (EncryptDecryptPart("perl and raku", "siderwrdulfipaarkcrw", False))
