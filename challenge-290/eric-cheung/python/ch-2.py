
def GetSumDigits (nInput):
    return sum([int(strDigit) for strDigit in str(nInput)])

## strInput = "17893729974"  ## Example 1
## strInput = "4137 8947 1175 5904"  ## Example 2
strInput = "4137 8974 1175 5904"  ## Example 3

strInputRev = "".join([strLoop for strLoop in strInput if strLoop.isdigit()])

nPayLoad = int(strInputRev[-1])
nSum = sum([GetSumDigits(int(strLoop) * (2 if nIndx % 2 == 0 else 1)) for nIndx, strLoop in enumerate(strInputRev[:-1][::-1])])

print ((nSum + nPayLoad) % 10 == 0)
