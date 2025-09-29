
## Example 1
## strInput = "programming"
## charInput = "g"

## Example 2
## strInput = "hello"
## charInput = "h"

## Example 3
## strInput = "abcdefghij"
## charInput = "h"

## Example 4
## strInput = "reverse"
## charInput = "s"

## Example 5
strInput = "perl"
charInput = "r"

nCharIndx = strInput.index(charInput)

strOutput = strInput[:nCharIndx + 1][::-1] + strInput[nCharIndx + 1:]

print (strOutput)
