
from itertools import permutations

## Example 1
## nFrom = 1
## nTo = 1000
## nMinCount = 1

## Example 2
## nFrom = 1500
## nTo = 2500
## nMinCount = 1

## Example 3
## nFrom = 1000000
## nTo = 1500000
## nMinCount = 5

## Example 4
## nFrom = 13427000
## nTo = 14100000
## nMinCount = 2

## Example 5
nFrom = 1030
nTo = 1130
nMinCount = 1

nCount = 0

for nLoop in range(nFrom, nTo + 1):
    arrPerm = list(permutations(list(str(nLoop))))
    arrOutput = [{nLoop : nMultiply} for nMultiply in range(2, 10) if tuple(str(nLoop * nMultiply)) in arrPerm]

    if len(arrOutput) < nMinCount:
        continue

    nCount = nCount + 1
    ## print (arrOutput)

print (nCount)
