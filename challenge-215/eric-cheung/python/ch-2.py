
## Example 1
## arrNum = [1, 0, 0, 0, 1]
## nCount = 1

## Example 2
## arrNum = [1, 0, 0, 0, 1]
## nCount = 2

## Example 3
arrNum = [1, 0, 0, 0, 0, 0, 0, 0, 1]
nCount = 3

for nIndxLoop in range(1, len(arrNum) - 1):

    if nCount == 0:
        break

    if arrNum[nIndxLoop - 1] == 0 and arrNum[nIndxLoop] == 0 and arrNum[nIndxLoop + 1] == 0:
        arrNum[nIndxLoop] = 1
        nCount = nCount - 1

if nCount == 0:
    print (1)
else:
    print (0)
