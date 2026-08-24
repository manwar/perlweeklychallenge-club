
def GetConvBaseToInt (strInput, nBase):
    if nBase < 2 or nBase > 64:
        return 0

    arrList = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "+", "/"]

    arrOutput = [arrList.index(charLoop) * (nBase ** nIndx) for nIndx, charLoop in enumerate(strInput[::-1])]

    return sum(arrOutput)

## Example 1
## strInput = "101010"
## nBase = 2

## Example 2
## strInput = "EEADEE"
## nBase = 16

## Example 3
## strInput = "755"
## nBase = 8

## Example 4
## strInput = "1BRJB"
## nBase = 36

## Example 5
strInput = "7MyqL"
nBase = 64

print (GetConvBaseToInt(strInput, nBase))
