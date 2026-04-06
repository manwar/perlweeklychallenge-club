
## Example 1
## strInput = "15456"
## charCheck = "5"

## Example 2
## strInput = "7332"
## charCheck = "3"

## Example 3
## strInput = "2231"
## charCheck = "2"

## Example 4
## strInput = "543251"
## charCheck = "5"

## Example 5
strInput = "1921"
charCheck = "1"

arrOutput = [int(strInput[:nIndx] + strInput[nIndx + 1:]) for nIndx, charLoop in enumerate(strInput) if charLoop == charCheck]

print (max(arrOutput))
