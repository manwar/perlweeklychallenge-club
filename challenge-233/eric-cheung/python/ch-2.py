
def MySwap(nInput_01, nInput_02):
    return [nInput_02, nInput_01]


## arrInput = [1, 1, 2, 2, 2, 3]  ## Example 1
## arrInput = [2, 3, 1, 3, 2]  ## Example 2
arrInput = [-1, 1, -6, 4, 5, -6, 1, 4, 1]  ## Example 3

arrUniq = sorted(list(set(arrInput)))
arrCount = [arrInput.count(nLoop) for nLoop in arrUniq]

arrOutput = []

## print (arrUniq)
## print (arrCount)

## print ("Before Bubble Sort")

## Bubble Sort
for nRowLoop in range(0, len(arrCount) - 1):
    for nColLoop in range(nRowLoop + 1, len(arrCount)):
        if arrCount[nRowLoop] > arrCount[nColLoop]:
            [arrCount[nRowLoop], arrCount[nColLoop]] = MySwap(arrCount[nRowLoop], arrCount[nColLoop])
            [arrUniq[nRowLoop], arrUniq[nColLoop]] = MySwap(arrUniq[nRowLoop], arrUniq[nColLoop])
        elif arrCount[nRowLoop] == arrCount[nColLoop] and arrUniq[nRowLoop] < arrUniq[nColLoop]:
            [arrUniq[nRowLoop], arrUniq[nColLoop]] = MySwap(arrUniq[nRowLoop], arrUniq[nColLoop])

## print ("After Bubble Sort")

## print (arrUniq)
## print (arrCount)

for nIndx, nLoop in enumerate(arrUniq):
    arrOutput = arrOutput + [nLoop] * arrCount[nIndx]

print (arrOutput)
