
## strInput = ["relocate", "delocate", "allocate"]  ## Example 1
## strInput = ["apple", "banana", "cherry"]  ## Example 2
## strInput = ["navigate", "cavity", "gravity"]  ## Example 3
## strInput = ["pedalgia", "pedalboard", "pedantic"]  ## Example 4
strInput = ["schoolmaster", "schoolhouse", "schooling"]  ## Example 5

strMin = min(strInput, key = len)

arrVowel = ["a", "e", "i", "o", "u"]

IsAllArr = (lambda arrGiven, bIn: all([(charLoop in arrVowel) if bIn else (charLoop not in arrVowel) for charLoop in arrGiven]))

def IsAlterVowel (strGiven):

    if len(strGiven) <= 1:
        return False

    arrIndxEven = [strGiven[nIndx] for nIndx in range(len(strGiven)) if nIndx % 2 == 0]
    arrIndxOdd = [strGiven[nIndx] for nIndx in range(len(strGiven)) if nIndx % 2 == 1]

    return IsAllArr(arrIndxEven, True) and IsAllArr(arrIndxOdd, False) or IsAllArr(arrIndxEven, False) and IsAllArr(arrIndxOdd, True)

arrOutput = []
strOutput = ""

for nRowIndx in range(len(strMin) - 1):
    for nColIndx in range(nRowIndx + 1, len(strMin)):

        strCheck = strMin[nRowIndx:nColIndx + 1]
        if not all([strCheck in strLoop for strLoop in strInput]):
            break

        if not IsAlterVowel(strCheck):
            break

        if len(strCheck) < len(strOutput):
            continue

        if len(strCheck) > len(strOutput):
            arrOutput = []
            strOutput = strCheck

        arrOutput.append(strCheck)


print (arrOutput)