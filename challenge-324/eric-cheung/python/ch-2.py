
from itertools import chain, combinations

## ==== METHOD 2 ====
def GetXOR (arrInput):
    nXOR = 0
    for nElem in arrInput:
        nXOR = nXOR ^ nElem

    return nXOR
## ==== METHOD 2 ====

## arrInt = [1, 3]  ## Example 1
## arrInt = [5, 1, 6]  ## Example 2
arrInt = [3, 4, 5, 6, 7, 8]  ## Example 3

arrSubsetList = list(chain.from_iterable(combinations(arrInt, nIndx) for nIndx in range(len(arrInt) + 1)))

## ==== METHOD 1 ====
## arrOutput = []

## for arrLoop in arrSubsetList:
    ## if len(arrLoop) == 0:
        ## continue

    ## nXOR = 0
    ## for nElem in arrLoop:
        ## nXOR = nXOR ^ nElem

    ## arrOutput.append(nXOR)
## ==== METHOD 1 ====

## ==== METHOD 2 ====
arrOutput = [GetXOR (arrLoop) for arrLoop in arrSubsetList if len(arrLoop) > 0]
## ==== METHOD 2 ====

print (sum(arrOutput))
