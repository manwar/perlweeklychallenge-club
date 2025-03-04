
def GetSumOfStr(strFunc):
    return str(sum([int(charLoop) for charLoop in strFunc]))

## Example 1
## strInput = "111122333"
## nInt = 3

## Example 2
## strInput = "1222312"
## nInt = 2

## Example 3
strInput = "100012121001"
nInt = 4

strOrig = strInput

while len(strOrig) > nInt:
    strTemp = "".join([GetSumOfStr(strOrig[nIndx : nIndx + nInt]) for nIndx in range(0, len(strOrig), nInt)])
    strOrig = strTemp

print (strOrig)
