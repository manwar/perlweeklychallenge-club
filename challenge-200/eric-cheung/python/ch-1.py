
## arrInput = [1, 2, 3, 4]  ## Example 1
arrInput = [2]  ## Example 2

def IsArithmetic(arrSubInput):

    if len(arrSubInput) < 3:
        return False

    nDiff = arrSubInput[1] - arrSubInput[0]

    for nLoop in range(2, len(arrSubInput)):
        if arrSubInput[nLoop] - arrSubInput[nLoop - 1] != nDiff:
            return False

    return True

arrOutput = []

for nLen in range(3, len(arrInput) + 1):
    for nIndx in range(0, len(arrInput) - nLen + 1):
        if IsArithmetic(arrInput[nIndx:nIndx + nLen]):
            arrOutput.append(arrInput[nIndx:nIndx + nLen])

print (arrOutput)