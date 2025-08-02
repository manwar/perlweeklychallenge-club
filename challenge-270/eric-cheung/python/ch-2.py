
nCost = 0

## Example 1
arrInt = [4, 1]
nX = 3
nY = 2

## Example 2
## arrInt = [2, 3, 3, 3, 5]
## nX = 2
## nY = 1

while len(set(arrInt)) > 1:
    arrInt = sorted(arrInt)
    
    if len(set(arrInt)) == 2 and arrInt.count(arrInt[0]) == 1:
        nCost = nCost + nX
    else:
        arrInt[1] = arrInt[1] + 1
        nCost = nCost + nY

    arrInt[0] = arrInt[0] + 1

print (nCost)
