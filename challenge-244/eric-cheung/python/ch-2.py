
## Ref.
## https://stackoverflow.com/questions/1482308/how-to-get-all-subsets-of-a-set-powerset

from itertools import chain, combinations

def GetPowerSet(arrInput):
    return list(chain.from_iterable(combinations(arrInput, rLoop) for rLoop in range(1, len(arrInput) + 1)))

arrNum = [2, 1, 4]  ## Example 1

nSum = 0

for arrLoop in GetPowerSet(arrNum):
    nMax = max(arrLoop)
    nMin = min(arrLoop)
    nSum = nSum + nMax * nMax * nMin

print (nSum)
