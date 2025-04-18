
from itertools import combinations

def SwapStr (strInput, arrIndx):
    arrStrNu = list(strInput)
    arrStrNu[arrIndx[0]] = strInput[arrIndx[1]]
    arrStrNu[arrIndx[1]] = strInput[arrIndx[0]]
    return "".join(arrStrNu)

## Example 1
strInput_01 = "desc"
strInput_02 = "dsec"

## Example 2
## strInput_01 = "fuck"
## strInput_02 = "fcuk"

## Example 3
## strInput_01 = "poo"
## strInput_02 = "eop"

## Example 4
## strInput_01 = "stripe"
## strInput_02 = "sprite"

## === Method 1 ===
## print ("".join(sorted(strInput_01)) == "".join(sorted(strInput_02)))
## === Method 1 ===

## === Method 2 ===
bIsFriendly = False
arrComb = combinations(range(len(strInput_02)), 2)
for arrLoop in list(arrComb):
    if SwapStr (strInput_02, arrLoop) == strInput_01:
        bIsFriendly = True
        break
print (bIsFriendly)
## === Method 2 ===
