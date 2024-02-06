
import numpy as np

## Example 1
## strPara = "Joe hit a ball, the hit ball flew far after it was hit."
## strBan = "hit"

## Example 2
strPara = "Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge."
strBan = "the"

arrWordSet = strPara.replace(strBan, "").replace(",", "").replace(".", "").split()
arrWordUniqSet = list(set(arrWordSet))
arrWordCount = [arrWordSet.count(wordLoop) for wordLoop in arrWordUniqSet]

## print (arrWordUniqSet)
## print (arrWordCount)

print (arrWordUniqSet[np.argmax(arrWordCount)])
