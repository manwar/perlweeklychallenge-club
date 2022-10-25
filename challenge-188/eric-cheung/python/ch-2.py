
## Example 1
## nX = 5
## nY = 4

## Example 2
nX = 4
nY = 6

## Example 3
nX = 2
nY = 5

## Example 4
nX = 3
nY = 1

## Example 5
nX = 7
nY = 4

nCount = 0

while (nX > 0 or nY > 0):

    print ("nCount = " + str(nCount) + ", nX = " + str(nX) + ", nY = " + str(nY))

    nCount = nCount + 1
    if nX == nY:
        break
    elif nX > nY:
        nX = nX - nY
    else:
        nY = nY - nX

print (nCount)

