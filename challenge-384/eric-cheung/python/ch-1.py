
def ConvNumToAnyBase(nNum, nBase):
    if nBase < 2 or nBase > 64:
        raise ValueError("Base must be between 2 and 64.")

    if nNum == 0:
        return "0"

    strDigits = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/"
    strResult = ""
    
    ## Track Negative Sign if Needed
    bIsNeg = nNum < 0
    nNum = abs(nNum)
    
    while nNum > 0:
        nNum, nRemain = divmod(nNum, nBase)
        strResult = strDigits[nRemain] + strResult

    return f"-{strResult}" if bIsNeg else strResult


## Example 1
## nNum = 42
## nBase = 2

## Example 2
## nNum = 15642094
## nBase = 16

## Example 3
## nNum = 493
## nBase = 8

## Example 4
## nNum = 2228519
## nBase = 36

## Example 5
nNum = 123456789
nBase = 64

print (ConvNumToAnyBase(nNum, nBase))
