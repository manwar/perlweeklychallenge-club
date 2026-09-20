## arrBoxes = [[1, 3], [3, 5], [6, 8], [2, 4]]  ## Example 1
## arrBoxes = [[4, 5], [4, 6], [6, 7], [2, 3], [4, 3]]  ## Example 2
## arrBoxes = [[5, 5], [5, 5], [5, 5]]  ## Example 3
## arrBoxes = [[2, 100], [3, 200], [4, 300], [5, 50], [5, 400]]  ## Example 4
arrBoxes = [[10, 20], [15, 10], [20, 30], [12, 18], [16, 25]]  ## Example 5

arrSorted = sorted(arrBoxes, key = lambda box: [box[0], box[1]])

arrOutput = []

for nRowIndx in range(0, len(arrSorted) - 1):
    arrTemp = [arrSorted[nRowIndx]]
    for nColIndx in range(nRowIndx + 1, len(arrSorted)):
        if arrSorted[nColIndx][0] > arrTemp[-1][0] and arrSorted[nColIndx][1] > arrTemp[-1][1]:
            arrTemp.append(arrSorted[nColIndx])
    arrOutput.append(arrTemp)

nMaxBoxes = len(max(arrOutput, key = len))

print (nMaxBoxes)