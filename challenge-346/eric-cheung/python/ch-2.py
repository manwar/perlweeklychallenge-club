
from itertools import product
from re import findall

## Example 1
## strInput = "123"
## nTarget = 6

## Example 2
## strInput = "105"
## nTarget = 5

## Example 3
## strInput = "232"
## nTarget = 8

## Example 4
## strInput = "1234"
## nTarget = 10

## Example 5
strInput = "1001"
nTarget = 2

arrOutput = []

arrChar = ["", "+", "-", "*"]
arrCartChar = [arrChar] * (len(strInput) - 1)

strExpr = "%".join([("" if nIndx == 0 else str(nIndx)) + charLoop for nIndx, charLoop in enumerate(list(strInput))])

arrAllList = list(product(*arrCartChar))
arrToRep = ["%" + str(nIndx) for nIndx in range(1, len(strInput))]

for arrLoop in arrAllList:
    strTemp = strExpr
    for strToRep, strNuStr in zip(arrToRep, arrLoop):
        strTemp = strTemp.replace(strToRep, strNuStr)

    if findall("0[0-9]", strTemp):
        continue

    if eval(strTemp) != nTarget:
        continue

    arrOutput.append(strTemp)

print (arrOutput)
