
## arrListInput = [1, 2, 3, 4, 5, 6]  ## Example 1
## arrListInput = [1, 2]  ## Example 2
arrListInput = [1]  ## Example 3

arrListOutput = []

if len(arrListInput) > 1:
    arrListInput.sort()

    for nElem in arrListInput:
        if nElem % 2 == 0:
            arrListOutput.append(nElem)

    for nElem in arrListInput:
        if nElem % 2 == 1:
            arrListOutput.append(nElem)
else:
    arrListOutput = arrListInput

print (arrListOutput)
