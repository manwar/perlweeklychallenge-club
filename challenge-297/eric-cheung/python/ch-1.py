
## arrBinary = [1, 0]  ## Example 1
## arrBinary = [0, 1, 0]  ## Example 2
## arrBinary = [0, 0, 0, 0, 0]  ## Example 3
arrBinary = [0, 1, 0, 0, 1, 0]  ## Example 4

nLen = 0

for nRow in range(len(arrBinary) - 1):
    for nCol in range(len(arrBinary) - 1, nRow, -1):
        if arrBinary[nRow : nCol + 1].count(1) != arrBinary[nRow : nCol + 1].count(0):
            continue

        nLen = max(nLen, nCol - nRow + 1)
        break

print (nLen)
