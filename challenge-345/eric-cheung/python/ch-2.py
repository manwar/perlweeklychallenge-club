
## Ref.:
## https://leetcode.com/problems/last-visited-integers/description/

## arrInts = [5, -1, -1]  ## Example 1
## arrInts = [3, 7, -1, -1, -1]  ## Example 2
## arrInts = [2, -1, 4, -1, -1]  ## Example 3
## arrInts = [10, 20, -1, 30, -1, -1]  ## Example 4
## arrInts = [-1, -1, 5, -1]  ## Example 5

## arrInts = [1, 2, -1, -1, -1]  ## Example 6
arrInts = [1, -1, 2, -1, -1]  ## Example 7

arrSeen = []
arrAns = []
arrMinusOne = []

for nElem in arrInts:
    if nElem > 0:
        arrSeen.insert(0, nElem)
    else:
        arrAns.append(arrSeen[len(arrMinusOne)] if len(arrMinusOne) < len(arrSeen) else nElem)
        arrMinusOne.append(nElem)

print (arrAns)
