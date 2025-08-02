
## strInput = "hello"  ## Example 1
## strInput = "perl"  ## Example 2
strInput = "raku"  ## Example 3

arrCode = [ord(charLoop) for charLoop in strInput]
arrCodeAbsDiff = [abs(arrCode[nIndx] - arrCode[nIndx + 1]) for nIndx in range(len(arrCode) - 1)]

print (sum(arrCodeAbsDiff))
