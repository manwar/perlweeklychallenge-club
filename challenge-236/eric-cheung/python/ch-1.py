
## arrInputBill = [5, 5, 5, 10, 20]  ## Example 1
## arrInputBill = [5, 5, 10, 10, 20]  ## Example 2
arrInputBill = [5, 5, 5, 20]  ## Example 3

arrChange = [0, 0, 0]
bSucceed = True

for nIndx in range(len(arrInputBill)):    
    if arrInputBill[nIndx] == 5:
        arrChange[0] = arrChange[0] + 1
    elif arrInputBill[nIndx] == 10:
        if arrChange[0] < 1:
            bSucceed = False
            break
        arrChange[0] = arrChange[0] - 1
        arrChange[1] = arrChange[1] + 1
    elif arrInputBill[nIndx] == 20:
        if arrChange[0] < 3 and (arrChange[0] < 1 or arrChange[1] < 1):
            bSucceed = False
            break
        arrChange[2] = arrChange[2] + 1
        if arrChange[1] > 0:
            arrChange[1] = arrChange[1] - 1
            arrChange[0] = arrChange[0] - 1
        else:
            arrChange[0] = arrChange[0] - 3

print (bSucceed)
