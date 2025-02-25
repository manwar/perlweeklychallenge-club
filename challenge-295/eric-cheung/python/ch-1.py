
## Ref.
## https://www.geeksforgeeks.org/word-break-problem-dp-32/

def CanWordBreak(strInput, arrDictInput):
    arrTemp = [False] * (len(strInput) + 1)

    arrTemp[0] = True

    for nRowLoop in range(len(strInput) + 1):
        for nColLoop in range(nRowLoop):
            if not arrTemp[nColLoop]:
                continue

            if not strInput[nColLoop : nRowLoop] in arrDictInput:
                continue

            arrTemp[nRowLoop] = True
            break

    return arrTemp[len(strInput)]


## Example 1
## arrDict = ["challenge", "weekly"]
## strInput = "weeklychallenge"

## Example 2
## arrDict = ["raku", "perl"]
## strInput = "perlrakuperl"

## Example 3
arrDict = ["sons", "sand", "daughters"]
strInput = "sonsanddaughters"

print (CanWordBreak(strInput, arrDict))
