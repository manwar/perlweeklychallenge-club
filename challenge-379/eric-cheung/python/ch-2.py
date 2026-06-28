
## Example 1
## nBase = 10
## nLimit = 1000

## Example 2
## nBase = 7
## nLimit = 1000

## Example 3
nBase = 16
nLimit = 1000

def IsArmstrongNum(nNumInput):
    nTempNum = nNumInput
    arrDigits = []

    while nTempNum > 0:
        arrDigits.append(nTempNum % nBase)
        nTempNum = int(nTempNum / nBase)

    nLen = len(arrDigits)
    nSumPower = sum(nDigit ** nLen for nDigit in arrDigits)

    return nSumPower == nNumInput

arrOutput = [nNum for nNum in range(nLimit + 1) if IsArmstrongNum(nNum)]

print (arrOutput)
