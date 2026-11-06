
from collections import Counter

GetStrArrDiff = (lambda strGiven: "_".join([str(ord(strGiven[nIndx]) - ord(strGiven[nIndx - 1])) for nIndx in range(1, len(strGiven))]))

## arrWords = ["ab", "bc", "cd", "zy"]  ## Example 1
## arrWords = ["cba", "fed", "azy"]  ## Example 2
## arrWords = ["pop", "ada", "beb", "cfc"]  ## Example 3
## arrWords = ["aaaa", "zzzz", "mmmm", "aaba"]  ## Example 4
arrWords = ["aceg", "bdfh", "cegi", "azbz"]  ## Example 5

arrOutput = list(map(GetStrArrDiff, arrWords))
objCounter = Counter(arrOutput)

arrDictKey = list(objCounter.keys())
arrDictVal = list(objCounter.values())

strKey = arrDictKey[arrDictVal.index(1)]
strOutput = arrWords[arrOutput.index(strKey)]

print (strOutput)
