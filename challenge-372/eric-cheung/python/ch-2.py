
## strInput = "aaaaa"  ## Example 1
## strInput = "abcdeba"  ## Example 2
## strInput = "abbc"  ## Example 3
## strInput = "abcaacbc"  ## Example 4
strInput = "laptop"  ## Example 5

arrSubStr = []

for nIndx, charLoop in enumerate(strInput[:-1]):
    ## print (nIndx, charLoop)
    nLastIndx = strInput.rfind(charLoop)
    arrSubStr.append("" if nIndx == nLastIndx else strInput[nIndx + 1 : nLastIndx])

print (max(map(len, arrSubStr)))
