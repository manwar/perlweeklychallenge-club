
## Example 1
## strInput = "challenge"
## charInput = "e"

## Example 2
## strInput = "programming"
## charInput = "a"

## Example 3
strInput = "champion"
charInput = "b"

if charInput in strInput:
    nPos = strInput.find(charInput)
    print ("".join(sorted(strInput[:nPos + 1])) + strInput[nPos + 1:])
else:
    print (strInput)
