
## strInput = "aeiou"  ## Example 1
## strInput = "aaeeeiioouu"  ## Example 2
## strInput = "aeiouuaxaeiou"  ## Example 3
## strInput = "uaeiou"  ## Example 4
strInput = "aeioaeioa"  ## Example 5

nLen = len(strInput)

arrOutput = []

for nFromIndx in range(nLen - 4):
    for nToIndx in range(nFromIndx + 5, nLen + 1):
        if set(strInput[nFromIndx:nToIndx]) != {"a", "e", "i", "o", "u"}:
            continue

        arrOutput.append(strInput[nFromIndx:nToIndx])

print (arrOutput)
