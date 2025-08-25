
## arrScore = ["5", "2", "C", "D", "+"]  ## Example 1
## arrScore = ["5", "-2", "4", "C", "D", "9", "+", "+"]  ## Example 2
## arrScore = ["7", "D", "D", "C", "+", "3"]  ## Example 3
## arrScore = ["-5", "-10", "+", "D", "C", "+"]  ## Example 4
arrScore = ["3", "6", "+", "D", "C", "8", "+", "D", "-2", "C", "+"]  ## Example 5

nIndx = 0
while nIndx < len(arrScore):
    strElem = arrScore[nIndx]

    if "-" in strElem:
        arrScore[nIndx] = -1 * int(strElem.replace("-", ""))
    elif strElem.isdigit():
        arrScore[nIndx] = int(strElem)
    elif strElem == "+":
        arrScore[nIndx] = sum(arrScore[nIndx - 2 : nIndx])
    elif strElem == "C":
        del arrScore[nIndx]
        del arrScore[nIndx - 1]
        nIndx = nIndx - 1
        continue
    elif strElem == "D":
        arrScore[nIndx] = 2 * int(arrScore[nIndx - 1])

    nIndx = nIndx + 1

## print (arrScore)
print (sum(arrScore))
