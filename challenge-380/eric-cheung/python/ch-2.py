## strInput = "z"  ## Example 1
## strInput = "a"  ## Example 2
## strInput = "bbc"  ## Example 3
## strInput = "racecar"  ## Example 4
strInput = "zyx"  ## Example 5

arrOutput = [(nIndx + 1) * (ord("z") - ord(charLoop) + 1) for nIndx, charLoop in enumerate(strInput)]

print (sum(arrOutput))