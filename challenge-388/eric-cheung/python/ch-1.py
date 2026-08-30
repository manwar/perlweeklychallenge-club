
from itertools import permutations, accumulate

def IsValidDyck(strWord):
    arrList = accumulate([1 if charLoop == "U" else -1 for charLoop in list(strWord)])
    return all(nElem >= 0 for nElem in arrList)

## nInt = 1  ## Example 1
## nInt = 2  ## Example 2
## nInt = 3  ## Example 3
## nInt = 0  ## Example 4
nInt = 4  ## Example 5

arrElem = ["U", "D"] * nInt
arrPerm = set(["".join(arrLoop) for arrLoop in permutations(arrElem)])

arrResult = [strWordLoop for strWordLoop in arrPerm if IsValidDyck(strWordLoop)]

print (arrResult)
