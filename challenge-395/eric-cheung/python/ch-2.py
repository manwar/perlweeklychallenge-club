
from itertools import permutations

## arrWords = ["MA", "AM", "MY", "ME"]  ## Example 1
## arrWords = ["SUN", "USE", "NET", "SEE", "TEN"]  ## Example 2
## arrWords = ["BOAT", "TEAL", "AREA", "TSAR", "OGRE"]  ## Example 3
## arrWords = ["CARD", "AREA", "REAR", "DART"]  ## Example 4
arrWords = ["HEART", "EMBER", "ABUSE", "RESIN", "TREND"]  ## Example 5

nWordLen = len(arrWords[0])

objPermList = list(permutations(arrWords, nWordLen))

arrOutput = []

for arrList in objPermList:
    ## print ("")
    ## print ("=====")
    arrRowList = list(arrList)
    ## print (arrRowList)

    arrColList = ["".join([strLoop[nRowIndx] for strLoop in arrRowList]) for nRowIndx in range(nWordLen)]
    ## print (arrColList)
    ## print ("=====")

    if arrRowList != arrColList:
        continue

    arrOutput.append(arrRowList)

print (arrOutput)
