
## arrNum = [1, 2, 3] ## Example 1
arrNum = [2, 3, 4] ## Example 2
nSum = 0

for nRow in range (0, len(arrNum) - 1):
    for nCol in range (nRow + 1, len(arrNum)):
        ## print (str(arrNum[nRow]) + " & " + str(arrNum[nCol]) + " = " + str(arrNum[nRow] & arrNum[nCol]))
        nSum = nSum + (arrNum[nRow] & arrNum[nCol])

print (nSum)
