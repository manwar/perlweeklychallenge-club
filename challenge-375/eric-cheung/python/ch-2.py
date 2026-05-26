
## Example 1
## nNum = 240
## nK = 2

## Example 2
## nNum = 1020
## nK = 2

## Example 3
## nNum = 444
## nK = 2

## Example 4
## nNum = 17
## nK = 2

## Example 5
nNum = 123
nK = 1

strNum = str(nNum)
nLen = len(strNum)

if nLen == nK:
    print (1)
else:
    arrOutput = [nIndx for nIndx in range(nLen - nK + 1) if nNum % int(strNum[nIndx:nIndx + nK]) == 0]
    print (len(arrOutput))
