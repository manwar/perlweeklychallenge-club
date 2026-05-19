
## Example 1
## arrList = [1, 2, 3, 4, 5]
## nInt = 2

## Example 2
## arrList = [1, 2, 3, 4, 5, 6]
## nInt = 3

## Example 3
## arrList = [1, 2, 3]
## nInt = 2

## Example 4
## arrList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
## nInt = 5

## Example 5
## arrList = [1, 2, 3]
## nInt = 4

## Example 6
arrList = [72, 57, 89, 55, 36, 84, 10, 95, 99, 35]
nInt = 7

nLen = len(arrList)

if nLen < nInt:
    print (-1)
else:
    nDiv = int(nLen / nInt)
    nMod = nLen % nInt

    nIndx = 0

    nPointer = 0
    nOrigPointer = 0

    arrOutput = []

    while nIndx < nInt:
        nPointer = nPointer + nDiv + (1 if nIndx < nMod else 0)
        arrOutput.append(arrList[nOrigPointer : nPointer])

        nOrigPointer = nPointer
        nIndx = nIndx + 1

    print (arrOutput)
