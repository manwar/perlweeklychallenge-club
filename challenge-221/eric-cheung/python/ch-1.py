
## Example 1
## arrInputWords = ["cat", "bt", "hat", "tree"]
## strChars = "atach"

## Example 2
arrInputWords = ["hello", "world", "challenge"]
strChars = "welldonehopper"

arrUniqChar = list(set(strChars))
arrUniqCharCount = [strChars.count(charLoop) for charLoop in arrUniqChar]

arrOutputWords = []
nSumCharLength = 0

for strLoop in arrInputWords:
    arrCharCount = arrUniqCharCount[:]
    bIsFound = True

    for charLoop in strLoop:
        if not charLoop in arrUniqChar:
            bIsFound = False
            break

        nIndx = arrUniqChar.index(charLoop)

        if arrCharCount[nIndx] == 0:
            bIsFound = False
            break

        arrCharCount[nIndx] = arrCharCount[nIndx] - 1

    if bIsFound:
        arrOutputWords.append(strLoop)
        nSumCharLength = nSumCharLength + len(strLoop)

## print (arrOutputWords)
print (nSumCharLength)
