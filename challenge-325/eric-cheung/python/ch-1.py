
## arrBinary = [0, 1, 1, 0, 1, 1, 1]  ## Example 1
## arrBinary = [0, 0, 0, 0]  ## Example 2
arrBinary = [1, 0, 1, 0, 1, 1]  ## Example 3

nMaxOne = 0
nCountOne = 0

for nBinLoop in arrBinary:
    if nBinLoop == 0:
        if nCountOne > nMaxOne:
            nMaxOne = nCountOne

        nCountOne = 0
        continue

    nCountOne = nCountOne + 1

if nCountOne > nMaxOne:
    nMaxOne = nCountOne

print (nMaxOne)
