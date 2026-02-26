
## strInput = "abca"  ## Example 1
## strInput = "xyz"  ## Example 2
## strInput = "code"  ## Example 3
## strInput = "hello"  ## Example 4
strInput = "a"  ## Example 5

strOutput = "".join([charLoop * (nIndx + 1) for nIndx, charLoop in enumerate(strInput)])

print (strOutput)
