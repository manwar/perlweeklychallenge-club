
## Example 1
## arrNum_01 = [1, 2, 3]
## arrNum_02 = [2, 4, 6]

## Example 2
arrNum_01 = [1, 2, 3, 3]
arrNum_02 = [1, 1, 2, 2]

arrOutput = []

arrOutput_01 = [nLoop for nLoop in list(set(arrNum_01)) if nLoop not in list(set(arrNum_02))]
if len(arrOutput_01) > 0:
    arrOutput.append(arrOutput_01)

arrOutput_02 = [nLoop for nLoop in list(set(arrNum_02)) if nLoop not in list(set(arrNum_01))]
if len(arrOutput_02) > 0:
    arrOutput.append(arrOutput_02)

print (arrOutput)
