
## Remarks
## https://www.geeksforgeeks.org/maximum-count-number-of-valley-elements-in-a-subarray-of-size-k/


## Valley
## First Part: Non-Increasing, Could Be Empty
## Second Part: Non-Decreasing, Could Be Empty


## arrInput = [1, 5, 5, 2, 8]  ## Example 1
## arrInput = [2, 6, 8, 5]  ## Example 2
## arrInput = [9, 8, 13, 13, 2, 2, 15, 17]  ## Example 3
## arrInput = [2, 1, 2, 1, 3]  ## Example 4
arrInput = [1, 3, 3, 2, 1, 2, 3, 3, 2]  ## Example 5


arrOutput = []
arrInterOutput = []
arrSubOutput = []
arrTrendUpSign = []
arrEqElem = []


bTrendUp = True
bPrevTrendUp = True
bChangeSign = True
bStart = True


for nIndx in range(1, len(arrInput)):

    if arrInput[nIndx - 1] < arrInput[nIndx]:
        bTrendUp = True
    elif arrInput[nIndx - 1] > arrInput[nIndx]:
        bTrendUp = False
    else:
        arrEqElem.append(arrInput[nIndx])

    if nIndx == 1:
        bPrevTrendUp = bTrendUp
        bChangeSign = True
    elif bTrendUp and bPrevTrendUp or not bTrendUp and not bPrevTrendUp:
        bChangeSign = False
    elif len(arrSubOutput) > 0:
        arrOutput.append(arrSubOutput)
        arrTrendUpSign.append(not bTrendUp)
        arrSubOutput = []
        bChangeSign = True  

    if bChangeSign:
        if len(arrEqElem) > 0:
            arrSubOutput = arrSubOutput + arrEqElem  ## Append List
            arrEqElem = []

        arrSubOutput.append(arrInput[nIndx - 1])

    arrSubOutput.append(arrInput[nIndx])

    bPrevTrendUp = bTrendUp


if len(arrSubOutput) > 0:
    arrOutput.append(arrSubOutput)
    arrTrendUpSign.append(bTrendUp)
    arrSubOutput = []


## print (arrOutput)
## print (arrTrendUpSign)

for nIndx, arrElemLoop in enumerate(arrOutput):

    ## print (bStart, arrTrendUpSign[nIndx])

    if bStart and arrTrendUpSign[nIndx]:
        if len(arrSubOutput) > 0:
            for nCount in range(0, len(arrElemLoop)):
                if arrElemLoop[nCount] != arrSubOutput[-1]:
                    break
            arrSubOutput = arrSubOutput + arrElemLoop[nCount:]  ## Append List
        else:
            arrSubOutput = arrSubOutput + arrElemLoop  ## Append List
        
        arrInterOutput.append(arrSubOutput)
        arrSubOutput = []

    elif bStart and not arrTrendUpSign[nIndx]:
        if len(arrSubOutput) > 0:
            for nCount in range(0, len(arrElemLoop)):
                if arrElemLoop[nCount] != arrSubOutput[-1]:
                    break
            arrSubOutput = arrSubOutput + arrElemLoop[nCount:]  ## Append List
        else:
            arrSubOutput = arrSubOutput + arrElemLoop  ## Append List

        bStart = False

    elif not bStart and arrTrendUpSign[nIndx]:
        if len(arrSubOutput) > 0:
            for nCount in range(0, len(arrElemLoop)):
                if arrElemLoop[nCount] != arrSubOutput[-1]:
                    break

            arrSubOutput = arrSubOutput + arrElemLoop[nCount:]  ## Append List
        else:
            arrSubOutput = arrSubOutput + arrElemLoop[1:]  ## Append List
        
    elif not bStart and not arrTrendUpSign[nIndx]:
        if len(arrSubOutput) > 0:
            arrInterOutput.append(arrSubOutput)
            arrSubOutput = []
        arrSubOutput = arrSubOutput + arrElemLoop  ## Append List
        bStart = True

if len(arrSubOutput) > 0:
    arrInterOutput.append(arrSubOutput)
    arrSubOutput = []


arrFinalOutput = arrInterOutput[0]
for arrElemLoop in arrInterOutput[1:]:
    if len(arrElemLoop) > len(arrFinalOutput):
        arrFinalOutput = arrElemLoop

## print (arrInterOutput)
print (arrFinalOutput)
