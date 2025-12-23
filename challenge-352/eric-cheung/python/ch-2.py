
## arrNums = [1, 0, 1]  ## Example: 0
## arrNums = [0, 1, 1, 0, 0, 1, 0, 1, 1, 1]  ## Example: 1
## arrNums = [1, 0, 1, 0, 1, 0]  ## Example: 2
## arrNums = [0, 0, 1, 0, 1]  ## Example: 3
## arrNums = [1, 1, 1, 1, 1]  ## Example: 4
## arrNums = [1, 1, 1, 1, 1]  ## Example: 5
arrNums = [1, 0, 1, 1, 0, 1, 0, 0, 1, 1]  ## Example: 6

arrBinToDec = [int("".join(list(map(str, arrNums[:nIndx + 1]))), 2) for nIndx in range(len(arrNums))]

arrDivFive = [nElem % 5 == 0 for nElem in arrBinToDec]

## print (arrBinToDec)
print (arrDivFive)
