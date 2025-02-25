
arrInts = [10, 4, 20, 1, 3, 2]  ## Example 1
## arrInts = [0, 6, 1, 8, 5, 2, 4, 3, 0, 7]  ## Example 2
## arrInts = [10, 30, 20]  ## Example 3

arrInts = sorted(arrInts)

## print (arrInts)

arrOutput = []

arrSubOutput = [arrInts[0]]

for nIndxLoop in range(1, len(arrInts)):
    if arrInts[nIndxLoop] - arrInts[nIndxLoop - 1] != 1:
        arrOutput.append(arrSubOutput)
        arrSubOutput = []

    arrSubOutput.append(arrInts[nIndxLoop])

arrOutput.append(arrSubOutput)

## print (arrOutput)

nMaxLen = max([len(arrLoop) for arrLoop in arrOutput])

print (-1 if nMaxLen == 1 else nMaxLen)
