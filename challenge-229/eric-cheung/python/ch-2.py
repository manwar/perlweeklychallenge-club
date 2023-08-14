
## Example 1
arrInput_01 = [1, 1, 2, 4]
arrInput_02 = [2, 4]
arrInput_03 = [4]

## Example 2
## arrInput_01 = [4, 1]
## arrInput_02 = [2, 4]
## arrInput_03 = [1, 2]

arrUnionSet = list(set(arrInput_01 + arrInput_02 + arrInput_03))

arrOutput = []

for nLoop in arrUnionSet:
    arrTemp = []
    if nLoop in arrInput_01:
        arrTemp.append(nLoop)
    if nLoop in arrInput_02:
        arrTemp.append(nLoop)
    if nLoop in arrInput_03:
        arrTemp.append(nLoop)
    if len(arrTemp) > 1:
        arrOutput.append(nLoop)

print (arrOutput)
