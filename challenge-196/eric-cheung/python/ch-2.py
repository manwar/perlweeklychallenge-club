
def getRangeList(arrInput):

    nStart = arrInput[0]
    nEnd = arrInput[0]

    arrOutput = []

    for nIndxLoop in range(1, len(arrInput)):
        if arrInput[nIndxLoop] == arrInput[nIndxLoop - 1] + 1:
            nEnd = arrInput[nIndxLoop]
            if nIndxLoop == len(arrInput) - 1:
                arrOutput.append([nStart, nEnd])
        else:
            if nEnd > nStart:
                arrOutput.append([nStart, nEnd])
            nStart = arrInput[nIndxLoop]

    return arrOutput

arrInputList = [1, 3, 4, 5, 7]  ## Example 1
## arrInputList = [1, 2, 3, 6, 7, 9]  ## Example 2
## arrInputList = [0, 1, 2, 4, 5, 6, 8, 9]  ## Example 3

print (getRangeList(arrInputList))
