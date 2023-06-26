
## arrInput = [2, 7, 4, 1, 8, 1]  ## Example 1
## arrInput = [1]  ## Example 2
arrInput = [1, 1]  ## Example 3

arrSort = sorted(arrInput, reverse = True)

if len(arrSort) == 1:
    print (arrSort[0])
else:
    while len(arrSort) > 1:
        nElem_01 = arrSort[0]
        nElem_02 = arrSort[1]
        arrSort.pop(1)
        arrSort.pop(0)
        if nElem_01 != nElem_02:
            arrSort.append(abs(nElem_01 - nElem_02))
            arrSort = sorted(arrSort, reverse = True)
    if len(arrSort) == 1:
        print (arrSort[0])
    else:
        print (0)
