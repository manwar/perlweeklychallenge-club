
## strInput = "p-er?l"  ## Example 1
## strInput = "wee-k!L-y"  ## Example 2
strInput = "_c-!h_all-en!g_e"  ## Example 3

arrAlphaBetic = [charLoop for charLoop in strInput if charLoop.isalpha()]
arrAlphaBetic = arrAlphaBetic[::-1]

nIndx = 0
strOutput = ""

for charLoop in strInput:
    if charLoop.isalpha():
        strOutput = strOutput + arrAlphaBetic[nIndx]
        nIndx = nIndx + 1
    else:
        strOutput = strOutput + charLoop

print (strOutput)
