
def IsStrSmaller (strInput_01, strInput_02):
    return int(strInput_01 + strInput_02) < int(strInput_02 + strInput_01)


arrInt = [20, 3]  ## Example 1
## arrInt = [3, 30, 34, 5, 9]  ## Example 2

arrOutput = [str(nLoop) for nLoop in arrInt]

for nRowLoop in range(len(arrOutput) - 1):
    for nColLoop in range(nRowLoop + 1, len(arrOutput)):
        if not IsStrSmaller(arrOutput[nRowLoop], arrOutput[nColLoop]):
            continue

        strTemp = arrOutput[nRowLoop]
        arrOutput[nRowLoop] = arrOutput[nColLoop]
        arrOutput[nColLoop] = strTemp

print ("".join(arrOutput))
