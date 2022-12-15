
def IsNumSpecial(nInput):

    if nInput < 11:
        return True

    arrList = list(map(int, str(nInput)))
    arrUniqList = list(set(arrList))

    for nLoop in arrUniqList:
        if arrList.count(nLoop) > 1:
            return False

    return True

def nCountNumSpecial(nNum):

    arrOutputList = []

    for nVar in range(1, nNum + 1):
        if IsNumSpecial(nVar):
            arrOutputList.append(nVar)

    return len(arrOutputList)


## nGivenInput = 15  ## Example 1
nGivenInput = 35  ## Example 2

print (nCountNumSpecial(nGivenInput))
