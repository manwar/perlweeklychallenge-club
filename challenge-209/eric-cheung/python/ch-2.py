
## arrAccount = [["A", "a1@a.com", "a2@a.com"], ["B", "b1@b.com"], ["A", "a3@a.com", "a1@a.com"]]  ## Example 1
arrAccount = [["A", "a1@a.com", "a2@a.com"], ["B", "b1@b.com"], ["A", "a3@a.com"], ["B", "b2@b.com", "b1@b.com"]]  ## Example 2

arrUser = [arrAccount[0][0]]
arrEmail = [arrAccount[0][1:]]
arrFinal = []

for nIndx in range(1, len(arrAccount)):
    if arrAccount[nIndx][0] not in arrUser:
        arrUser.append(arrAccount[nIndx][0])
        arrEmail.append(arrAccount[nIndx][1:])
    else:
        nFindIndx = arrUser.index(arrAccount[nIndx][0])
        if len(list(set(arrEmail[nFindIndx]) & set(arrAccount[nIndx][1:]))) == 0:
            arrUser.append(arrAccount[nIndx][0])
            arrEmail.append(arrAccount[nIndx][1:])
        else:
            arrEmail[nFindIndx] = sorted(list(set(arrEmail[nFindIndx] + arrAccount[nIndx][1:])))

## print (arrUser)
## print (arrEmail)

for nIndx in range(0, len(arrUser)):
    arrFinal.append([arrUser[nIndx], str(arrEmail[nIndx][:])[1:-1]])

print (arrFinal)
