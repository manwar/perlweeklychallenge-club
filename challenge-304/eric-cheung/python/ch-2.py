
## Example 1
## arrInts = [1, 12, -5, -6, 50, 3]
## nN = 4

## Example 2
arrInts = [5]
nN = 1

dMaxAvg = sum(arrInts[:nN]) / nN

for nIndx in range(1, len(arrInts) - nN + 1):
    dTempAvg = sum(arrInts[nIndx: nIndx + nN]) / nN
    dMaxAvg = max(dMaxAvg, dTempAvg)

print (dMaxAvg)
