
def IsStrGreater(strInput_01, strInput_02):
    global arrAlien
    if strInput_01 == strInput_02:
        return False

    nMinLen = min(len(strInput_01), len(strInput_02))

    if strInput_01[:nMinLen] == strInput_02[:nMinLen]:
        return len(strInput_01) > len(strInput_02)

    for nIndx in range(nMinLen):
        if strInput_01[nIndx] == strInput_02[nIndx]:
            continue
        return arrAlien.index(strInput_01[nIndx]) > arrAlien.index(strInput_02[nIndx])

## Example 1
## arrWords = ["perl", "python", "raku"]
## arrAlien = ["h", "l", "a", "b", "y", "d", "e", "f", "g", "i", "r", "k", "m", "n", "o", "p", "q", "j", "s", "t", "u", "v", "w", "x", "c", "z"]

## Example 2
arrWords = ["the", "weekly", "challenge"]
arrAlien = ["c", "o", "r", "l", "d", "a", "b", "t", "e", "f", "g", "h", "i", "j", "k", "m", "n", "p", "q", "s", "w", "u", "v", "x", "y", "z"]

for nRowLoop in range(len(arrWords) - 1):
    for nColLoop in range(nRowLoop + 1, len(arrWords)):
        if not IsStrGreater(arrWords[nRowLoop], arrWords[nColLoop]):
            continue

        strTemp = arrWords[nRowLoop]
        arrWords[nRowLoop] = arrWords[nColLoop]
        arrWords[nColLoop] = strTemp

print (arrWords)
