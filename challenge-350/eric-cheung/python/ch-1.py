
## strInput = "abcaefg"  ## Example 1
## strInput = "xyzzabc"  ## Example 2
## strInput = "aababc"  ## Example 3
## strInput = "qwerty"  ## Example 4
strInput = "zzzaaa"  ## Example 5

arrOutput = [strInput[nIndx : nIndx + 3] for nIndx in range(len(strInput) - 2) if len(set(strInput[nIndx : nIndx + 3])) == 3]

print (len(arrOutput))
