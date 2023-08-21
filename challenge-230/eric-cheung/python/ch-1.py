
## arrInt = [1, 34, 5, 6]  ## Example 1
arrInt = [1, 24, 51, 60]  ## Example 2

arrOutput = []

for nLoop in arrInt:
    arrOutput = arrOutput + [int(strElem) for strElem in str(nLoop)]

print (arrOutput)
