
## strInput = "abbaca"  ## Example 1
## strInput = "azxxzy"  ## Example 2
## strInput = "aaaaaaaa"  ## Example 3
## strInput = "aabccba"  ## Example 4
strInput = "abcddcba"  ## Example 5

arrOutput = list(strInput)

nIndx = 1
while nIndx < len(arrOutput):
    if arrOutput[nIndx] == arrOutput[nIndx - 1]:
        arrOutput.pop(nIndx)
        arrOutput.pop(nIndx - 1)
        nIndx = 1
        continue
    nIndx = nIndx + 1

print ("".join(arrOutput))
