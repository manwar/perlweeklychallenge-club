
## Example 1
## strInput_01 = "acb"
## strInput_02 = "cba"
## strInput_03 = "cdb"

## Example 2
## strInput_01 = "aab"
## strInput_02 = "aac"
## strInput_03 = "ad"

## Example 3
## strInput_01 = "bc"
## strInput_02 = "je"
## strInput_03 = "jg"

## Example 4
## strInput_01 = "a"
## strInput_02 = "aaaa"
## strInput_03 = "aa"

## Example 5
## strInput_01 = "c"
## strInput_02 = "d"
## strInput_03 = "h"

## Example 6
strInput_01 = "gfi"
strInput_02 = "hbf"
strInput_03 = "bdhd"

funConv = (lambda charLoop: str(ord(charLoop) - 97))

nVal_01 = int("".join(list(map(funConv, list(strInput_01)))))
nVal_02 = int("".join(list(map(funConv, list(strInput_02)))))
nVal_03 = int("".join(list(map(funConv, list(strInput_03)))))

print (nVal_01 + nVal_02 == nVal_03)
