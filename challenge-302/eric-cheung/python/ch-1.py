
## Ref.:
## https://leetcode.com/problems/ones-and-zeroes/description/
## https://stackoverflow.com/questions/1482308/how-to-get-all-subsets-of-a-set-powerset

from itertools import chain, combinations

def GetPowSet(arrSet):
    return chain.from_iterable(combinations(arrSet, arrSubLoop) for arrSubLoop in range(len(arrSet), 0, -1))

## Example 1
arrStr = ["10", "0001", "111001", "1", "0"]
nX = 5
nY = 3

## Example 2
## arrStr = ["10", "1", "0"]
## nX = 1
## nY = 1

nMaxLenSubSet = 0

for arrLoop in list(GetPowSet(arrStr)):
    setLoop = list(arrLoop)

    ## print (setLoop)

    nCountOne = sum([strLoop.count("1") for strLoop in setLoop])
    nCountZero = sum([strLoop.count("0") for strLoop in setLoop])

    if nCountZero > nX:
        continue

    if nCountOne > nY:
        continue

    if len(setLoop) > nMaxLenSubSet:
        nMaxLenSubSet = len(setLoop)
        break

print (nMaxLenSubSet)
