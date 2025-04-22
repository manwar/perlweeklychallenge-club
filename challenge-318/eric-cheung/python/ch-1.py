
## strInput = "abccccd"  ## Example 1
## strInput = "aaabcddddeefff"  ## Example 2
strInput = "abcdd"  ## Example 3

arrOutput = []
strTemp = ""

for charLoop in strInput:
    if not strTemp:
        strTemp = charLoop
    elif strTemp[-1] == charLoop:
        strTemp = strTemp + charLoop
    else:
        if len(strTemp) >= 3:
            arrOutput.append(strTemp)
        strTemp = charLoop

if len(strTemp) >= 3:
    arrOutput.append(strTemp)

print (arrOutput)
