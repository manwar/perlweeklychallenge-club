
## strInput = "pERl"  ## Example 1
## strInput = "rakU"  ## Example 2
strInput = "PyThOn"  ## Example 3

strOutput = "".join([charLoop.lower() if charLoop.isupper() else charLoop.upper() for charLoop in strInput])

print (strOutput)
