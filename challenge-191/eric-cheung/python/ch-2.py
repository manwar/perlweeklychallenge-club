
from itertools import permutations

def IsCuteList(arrInput):
    for nIndx in range(0, len(arrInput)):
        if arrInput[nIndx] % (nIndx + 1) != 0 and (nIndx + 1) % arrInput[nIndx] != 0:
            return False

    return True

## nInput = 2
## nInput = 3
## nInput = 4
## nInput = 5
## nInput = 6
## nInput = 7
## nInput = 8
## nInput = 9
## nInput = 10
## nInput = 11
## nInput = 12
## nInput = 13
## nInput = 14
nInput = 15

nCount = 0

arrPermList = permutations(list(range(1, nInput + 1)))

for pernLoop in list(arrPermList): 
    if IsCuteList(pernLoop):
        print (pernLoop)
        nCount = nCount + 1

print (str(nCount))
