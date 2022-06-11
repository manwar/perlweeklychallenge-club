
## arrNum = [1, 2, 3, 4, 5] ## Example 1
arrNum = [1, 3, 5, 7, 9] ## Example 2

arrResult = []

for nRow in range(0, len(arrNum)):

    ## print (nRow)

    if (nRow == 0):
        arrResult = arrNum
        ## print (arrResult)
        continue

    arrTemp = arrResult
    arrResult = [arrTemp[1]]

    for nCol in range(2, len(arrTemp)):
        arrResult.append(arrResult[-1] + arrTemp[nCol])

    ## print (arrResult)
    

print (arrResult[0])
