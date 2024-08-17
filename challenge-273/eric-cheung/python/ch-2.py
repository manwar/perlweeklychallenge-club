
## strInput = "aabb"  ## Example 1
## strInput = "abab"  ## Example 2
## strInput = "aaa"  ## Example 3
strInput = "bbb"  ## Example 4

if strInput.count("b") <= 1:
    print (False)
else:
    nFirstBPos = strInput.index("b")

    nNumOfA = strInput[nFirstBPos + 1:].count("a")
    nNumOfB = strInput[nFirstBPos + 1:].count("b")

    print (nNumOfA == 0 and nNumOfB > 0)
