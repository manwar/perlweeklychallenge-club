
## strInput = "the1weekly2challenge2"  ## Example 1
## strInput = "go21od1lu5c7k"  ## Example 2
strInput = "4p3e2r1l"  ## Example 3

strOutput = "".join([charLoop if charLoop.isnumeric() else " " for charLoop in strInput])

arrOutput = set([int(strNumLoop) for strNumLoop in strOutput.split(" ") if strNumLoop])

print (arrOutput)
