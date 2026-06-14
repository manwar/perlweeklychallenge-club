
## strInput = "abcba"  ## Example 1
## strInput = "racecar"  ## Example 2
## strInput = "abcd"  ## Example 3
## strInput = "banana"  ## Example 4
strInput = "hello"  ## Example 5

strRev = strInput[::-1]

arrOutput = [nIndx for nIndx in range(len(strInput) - 1) if strInput[nIndx:nIndx + 2] in strRev]

print (len(arrOutput) > 0)
