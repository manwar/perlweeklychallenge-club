
from collections import deque

def GetMinMutation(strStartGene, strEndGene, arrBankGene):
    if strStartGene == strEndGene:
        return 0

    setBankGene = set(arrBankGene)

    if strEndGene not in setBankGene:
        return -1

    objQueue = deque([(strStartGene, 0)])
    objVisited = {strStartGene}

    while objQueue:
        strCurGene, nStep = objQueue.popleft()

        if strCurGene == strEndGene:
            return nStep

        for nIndx in range(len(strCurGene)):
            for charLoop in "ACGT":
                if charLoop == strCurGene[nIndx]:
                    continue

                strNextGene = strCurGene[:nIndx] + charLoop + strCurGene[nIndx + 1:]
                if strNextGene in setBankGene and strNextGene not in objVisited:
                    objVisited.add(strNextGene)
                    objQueue.append((strNextGene, nStep + 1))

    return -1


## Example 1
## strGivenStartGene = "AACCGGTT"
## strGivenEndGene = "AACCGGTA"
## strGivenGeneBank = ["AACCGCTA", "AAACGGTA"]

## Example 2
## strGivenStartGene = "AACCGGTT"
## strGivenEndGene = "AACCGGAA"
## strGivenGeneBank = ["AACCGGTA", "AACCGGAA", "AACCGCTA", "AACCCTAA", "AACCGTAA"]

## Example 3
## strGivenStartGene = "AAAAAAAA"
## strGivenEndGene = "AAAAACCC"
## strGivenGeneBank = ["CAAAAAAA", "CCAAAAAA", "AAAAAAAC"]

## Example 4
## strGivenStartGene = "GAAAAAAA"
## strGivenEndGene = "GCCCCCCC"
## strGivenGeneBank = ["GCAAAAAA", "GCCAAAAA", "GCCCAAAA", "GCCCCAAA", "GCCCCCAA", "GCCCCCCA", "GCCCCCCC"]

## Example 5
strGivenStartGene = "AACCGGTT"
strGivenEndGene = "AACCGGTT"
strGivenGeneBank = ["AACCGGTA"]

print (GetMinMutation(strGivenStartGene, strGivenEndGene, strGivenGeneBank))
