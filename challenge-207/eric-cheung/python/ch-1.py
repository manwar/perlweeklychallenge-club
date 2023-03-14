
arrKeyBoardRow = ["qwertyuiop", "asdfghjkl", "zxcvbnm"]

arrInputWords = ["Hello", "Alaska", "Dad", "Peace"]  ## Example 1
## arrInputWords = ["OMG", "Bye"]  ## Example 2

arrKeyBoardChar = []
for arrLoop in arrKeyBoardRow:
    arrKeyBoardChar.append(list(arrLoop))

arrOutputWords = []

for arrLoop in arrInputWords:

    strLoopLower = arrLoop.lower()

    for nIndx in range(0, len(arrKeyBoardChar)):
        if strLoopLower[0] in arrKeyBoardChar[nIndx]:
            break

    bSameRow = True
    for nLoop in range(1, len(arrLoop)):
        if strLoopLower[nLoop] not in arrKeyBoardChar[nIndx]:
            bSameRow = False
            break

    if bSameRow:
        arrOutputWords.append(arrLoop)

print (arrOutputWords)
