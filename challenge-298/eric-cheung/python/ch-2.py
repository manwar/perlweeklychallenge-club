
## arrIntervals = [[3, 4], [2, 3], [1, 2]]  ## Example 1
## arrIntervals = [[1, 4], [2, 3], [3, 4]]  ## Example 2
## arrIntervals = [[1, 2]]  ## Example 3
arrIntervals = [[1, 4], [2, 2], [3, 4]]  ## Example 4

arrStart = [arrLoop[0] for arrLoop in arrIntervals]

## print (arrStart)

arrOutput = []
for arrLoop in arrIntervals:
    nEnd = arrLoop[1]
    nIndxFnd = -1
    nDiff = nEnd

    for nIndxLoop, nStartLoop in enumerate(arrStart):
        if nStartLoop < nEnd:
            continue

        if nStartLoop - nEnd >= nDiff:
            continue

        nDiff = nStartLoop - nEnd
        nIndxFnd = nIndxLoop

    arrOutput.append(nIndxFnd)

print (arrOutput)
