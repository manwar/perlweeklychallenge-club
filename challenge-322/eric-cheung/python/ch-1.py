
## Example 1
## strInput = "ABC-D-E-F"
## nInput = 3

## Example 2
## strInput = "A-BC-D-E"
## nInput = 2

## Example 3
strInput = "-A-B-CD-E"
nInput = 4

arrSplit = strInput.split("-")

arrOutput = []
strTemp = arrSplit[-1]

for strLoop in arrSplit[:-1][::-1]:
    if len(strTemp) == nInput:
        arrOutput.insert(0, strTemp)
        strTemp = strLoop
    else:
        strTemp = strLoop + strTemp

arrOutput.insert(0, strTemp)

print ("-".join(arrOutput))
