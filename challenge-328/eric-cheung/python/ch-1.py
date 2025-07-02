
## strInput = "a?z"  ## Example 1
## strInput = "pe?k"  ## Example 2
strInput = "gra?te"  ## Example 3

arrOutput = []

arrReplaceList = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]

for nIndx, charLoop in enumerate(strInput):
    if charLoop != "?":
        arrOutput.append(charLoop)
        continue

    ## print (nIndx, charLoop)

    arrExclude = []
    if nIndx > 0:
        arrExclude.append(strInput[nIndx - 1])

    if nIndx < len(strInput) - 1:
        arrExclude.append(strInput[nIndx + 1])

    arrOutput.append([charSubLoop for charSubLoop in arrReplaceList if not charSubLoop in arrExclude][0])

print ("".join(arrOutput))
