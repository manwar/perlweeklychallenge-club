
## Example 1
## strInput = "RakuPerl"
## nSize = 4
## strFiller = "*"

## Example 2
## strInput = "Python"
## nSize = 5
## strFiller = "0"

## Example 3
## strInput = "12345"
## nSize = 3
## strFiller = "x"

## Example 4
## strInput = "HelloWorld"
## nSize = 3
## strFiller = "_"

## Example 5
strInput = "AI"
nSize = 5
strFiller = "!"

nStrLen = len(strInput)

arrOutput = [strInput[nIndx:nIndx + nSize] + strFiller * max(0, nIndx + nSize - nStrLen) for nIndx in range(0, len(strInput), nSize)]

print (arrOutput)
