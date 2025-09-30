
import sys

## Example 1
## strInput = "Hello World"
## arrKey = ["d"]

## Example 2
## strInput = "apple banana cherry"
## arrKey = ["a", "e"]

## Example 3
## strInput = "Coding is fun"
## arrKey = []

## Example 4
## strInput = "The Weekly Challenge"
## arrKey = ["a", "b"]

## Example 5
strInput = "Perl and Python"
arrKey = ["p"]

arrInput = strInput.split(" ")

if len(arrKey) == 0:
    print (len(arrInput))
    sys.exit()

arrOutput = []

for strLoop in arrInput:
    bIsValid = (len([charLoop for charLoop in arrKey if charLoop in strLoop.lower()]) == 0)

    if not bIsValid:
        continue

    arrOutput.append(strLoop)

print (len(arrOutput))
