
## arrNums = [9, 4, 2, 10, 7, 8, 8, 1, 9]  ## Example 1
## arrNums = [1, 7, 4, 9, 2, 5]  ## Example 2
## arrNums = [1, 2, 3, 4, 5]  ## Example 3
## arrNums = [4, 4, 4]  ## Example 4
arrNums = [10, 20, 15, 12, 18]  ## Example 5

arrOutput = []
arrTemp = []
nFlag = 0
## -1: Prev < Curr
## 0: No Indicator
## 1: Prev > Curr

for nLoop in arrNums:
    if len(arrTemp) == 0:
        arrTemp.append(nLoop)
    elif nLoop < arrTemp[-1] and nFlag <= 0:
        arrTemp.append(nLoop)
        nFlag = 1
    elif nLoop > arrTemp[-1] and nFlag >= 0:
        arrTemp.append(nLoop)
        nFlag = -1
    else:
        arrOutput.append(arrTemp)
        arrTemp = [arrTemp[-1]]
        if nLoop < arrTemp[-1]:
            arrTemp.append(nLoop)
            nFlag = 1
        elif nLoop > arrTemp[-1]:
            arrTemp.append(nLoop)
            nFlag = -1
        else:
            arrTemp = [nLoop]
            nFlag = 0

if len(arrTemp) > 0:
    arrOutput.append(arrTemp)

print (len(max(arrOutput, key = lambda row: len(row))))
