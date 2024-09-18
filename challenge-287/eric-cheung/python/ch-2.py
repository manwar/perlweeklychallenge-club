
def IsValidDef (strFunc, bAllowDecimal):
    if not bAllowDecimal and "." in strFunc:
        return False

    if strFunc == ".":
        return False

    if (strFunc[0] in ["+", "-"]):
        strFunc = strFunc[1:]

    arrPart = strFunc.split(".")

    if len(arrPart) > 2:
        return False

    for strLoop in arrPart:
        if not strLoop:
            continue
        if not strLoop.isnumeric():
            return False

    return True

def IsValidNum (strFunc):
    arrPart = strFunc.lower().split("e")

    if len(arrPart) > 2:
        return False

    for nIndx, strLoop in enumerate(arrPart):
        if not IsValidDef (strLoop, nIndx == 0):
            return False

    return True

## strInput = "1"  ## Example 1
## strInput = "a"  ## Example 2
## strInput = "."  ## Example 3
## strInput = "1.2e4.2"  ## Example 4
## strInput = "-1."  ## Example 5
## strInput = "+1E-8"  ## Example 6
strInput = ".44"  ## Example 7

print (IsValidNum(strInput))
