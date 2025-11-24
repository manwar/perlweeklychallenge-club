
## strInput = "textbook"  ## Example 1
## strInput = "aaaaa"  ## Example 2
## strInput = "hoorayyy"  ## Example 3
## strInput = "x"  ## Example 4
strInput = "aabcccddeeffffghijjk"  ## Example 5

strTemp = strInput[0]
arrOutput = []

nIndx = 1
while nIndx < len(strInput):
    if strInput[nIndx] == strTemp[-1]:
        strTemp = strTemp + strInput[nIndx]
    else:
        arrOutput.append(strTemp)
        strTemp = strInput[nIndx]

    nIndx = nIndx + 1

arrOutput.append(strTemp)

print (max([len(strLoop) for strLoop in arrOutput]))
