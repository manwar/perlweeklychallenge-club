
## strInput = "111000"  ## Example 1
## strInput = "00011"  ## Example 2
## strInput = "01011"  ## Example 3
## strInput = "010101"  ## Example 4
strInput = "00001"  ## Example 5

strFind = "01"
strReplace = "10"

nCount = 0
while strInput.find(strFind) > -1:
    strInput = strInput.replace(strFind, strReplace)
    nCount = nCount + 1

print (nCount)