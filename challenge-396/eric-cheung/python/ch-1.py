
## Example 1
## arrOrder = [3, 1, 4, 2, 5]
## arrFriends = [1, 2, 4]

## Example 2
## arrOrder = [5, 4, 3, 2, 1]
## arrFriends = [1, 3, 5]

## Example 3
## arrOrder = [2, 4, 1, 3]
## arrFriends = [1, 2, 3, 4]

## Example 4
## arrOrder = [4, 1, 3, 2]
## arrFriends = [3]

## Example 5
arrOrder = [1, 3, 2, 6, 5, 4]
arrFriends = [1, 2, 3]

arrOutput = arrFriends
if len(arrFriends) > 1:
    arrSorted = sorted([[arrOrder.index(nElem), nElem] for nElem in arrFriends])
    arrOutput = [arrLoop[1] for arrLoop in arrSorted]

print (arrOutput)
