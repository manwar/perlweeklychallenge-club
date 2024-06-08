
## arrInt = [2, 1, 3, 4, 5]  ## Example 1
## arrInt = [3, 2, 4]  ## Example 2
arrInt = [5, 4, 3 ,8]  ## Example 3

arrOut_01 = [arrInt[0]]
arrOut_02 = [arrInt[1]]

for nLoop in arrInt[2:]:
    if arrOut_01[-1] > arrOut_02[-1]:
        arrOut_01.append(nLoop)
    else:
        arrOut_02.append(nLoop)

print (arrOut_01 + arrOut_02)
