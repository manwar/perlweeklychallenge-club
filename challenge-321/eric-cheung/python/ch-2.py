
def GetRefineStr (strInput):
    arrTemp = list(strInput)
    while "#" in arrTemp:
        nPosBackSpace = arrTemp.index("#")
        arrTemp.pop(nPosBackSpace)
        arrTemp.pop(nPosBackSpace - 1)

    return "".join(arrTemp)

## Example 1
## strInput_01 = "ab#c"
## strInput_02 = "ad#c"

## Example 2
## strInput_01 = "ab##"
## strInput_02 = "a#b#"

## Example 3
strInput_01 = "a#b"
strInput_02 = "c"

strInput_01_rev = GetRefineStr(strInput_01)
strInput_02_rev = GetRefineStr(strInput_02)

## print (strInput_01_rev)
## print (strInput_02_rev)

print (strInput_01_rev == strInput_02_rev)
