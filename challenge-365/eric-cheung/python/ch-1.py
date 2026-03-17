
## Example 1
## strInput = "abc"
## nInput = 1

## Example 2
## strInput = "az"
## nInput = 2

## Example 3
## strInput = "cat"
## nInput = 1

## Example 4
## strInput = "dog"
## nInput = 2

## Example 5
strInput = "perl"
nInput = 3

strConv = "".join([str(ord(charLoop) - 96) for charLoop in strInput])

## print (strConv)

strSum = strConv

for nIndx in range(nInput):
    if len(strSum) == 1:
        break

    strSum = str(sum([int(strDigit) for strDigit in strSum]))

print (strSum)
