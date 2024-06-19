
## arrInput = [[12, 11, 41], [15, 5, 35]]  ## Example 1
arrInput = [[12, 3, 41], [15, 9, 35], [30, 5, 25]]  ## Example 2

## Remarks
## [Period, Start, Travel Time], [Bus 1], [Bus 2], ...

arrBus = []
arrOutput = []

for arrLoop in arrInput:
    nMinStart = arrLoop[1]
    while nMinStart < 60:
        arrBus.append([nMinStart, nMinStart + arrLoop[2]])
        nMinStart = nMinStart + arrLoop[0]

arrBus = sorted(arrBus, key = lambda nElem: (nElem[0], nElem[1]))
arrBus.append([arrBus[0][0] + 60, arrBus[0][1] + 60])

arrStart = [arrLoop[0] for arrLoop in arrBus]

## print (arrBus)

for nLoop in range(60):

    if nLoop <= arrBus[0][0] or nLoop > arrBus[-2][0]:
        nIndx = 0
    else:
        nIndx = min([nIndx for nIndx, nStartMin in enumerate(arrStart) if nLoop <= nStartMin])

    if arrBus[nIndx][1] <= arrBus[nIndx + 1][1]:
        continue

    arrOutput.append(nLoop)

print (arrOutput)
