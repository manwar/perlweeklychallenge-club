
arrInt = [3, 2, 3, 2, 2, 2]  ## Example 1
## arrInt = [1, 2, 3, 4]  ## Example 2

arrUniq = list(set(arrInt))
arrCount = [arrInt.count(nLoop) for nLoop in arrUniq]
arrOutput = []

if any(nLoop % 2 == 1 for nLoop in arrCount):
    print ([])
else:
    for nIndx in range(len(arrUniq)):
        for nCount in range(int(arrCount[nIndx] / 2)):
            arrOutput.append([arrUniq[nIndx], arrUniq[nIndx]])

    print (arrOutput)
