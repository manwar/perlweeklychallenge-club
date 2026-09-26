
## strInput = "pinnipeds"  ## Example 1
## strInput = "abcd"  ## Example 2
## strInput = "bananas"  ## Example 3
## strInput = "dissident"  ## Example 4
strInput = "cailliachs"  ## Example 5

strRev = strInput[::-1]

## print (strRev)

nIndx = 0
while nIndx < len(strRev):
    strCheck = strRev[nIndx:]
    if strInput.startswith(strCheck):
        break
    nIndx = nIndx + 1

strOutput = strRev[:nIndx] + strInput

print (strOutput)