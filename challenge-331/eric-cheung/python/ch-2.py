
def IsBuddyStr (strSource, strTarget):
    arrSource = list(strSource)

    for nRow in range(0, len(arrSource) - 1):
        for nCol in range(nRow + 1, len(arrSource)):
            arrTemp = arrSource[:]
            arrTemp[nRow] = arrSource[nCol]
            arrTemp[nCol] = arrSource[nRow]
            strSwap = "".join(arrTemp)
            if strSwap == strTarget:
                return True

    return False

## Example 1
## strInputSource = "fuck"
## strInputTarget = "fcuk"

## Example 2
## strInputSource = "love"
## strInputTarget = "love"

## Example 3
## strInputSource = "fodo"
## strInputTarget = "food"

## Example 4
strInputSource = "feed"
strInputTarget = "feed"

print (IsBuddyStr(strInputSource, strInputTarget))
