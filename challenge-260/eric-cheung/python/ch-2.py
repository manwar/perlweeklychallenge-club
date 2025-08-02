
from itertools import permutations

strWord = "CAT"  ## Example 1
## strWord = "GOOGLE"  ## Example 2
## strWord = "SECRET"  ## Example 3

arrPermList = permutations(list(strWord))

arrPermStrList = sorted(list(set(["".join(arrLoop) for arrLoop in list(arrPermList)])))

print (arrPermStrList.index(strWord) + 1)
