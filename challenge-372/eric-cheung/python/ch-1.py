
## strInput = "  challenge  "  ## Example 1
## strInput = "coding  is  fun"  ## Example 2
## strInput = "a b c  d"  ## Example 3
## strInput = "  team      pwc  "  ## Example 4
strInput = "   the  weekly  challenge  "  ## Example 5

nSpace = strInput.count(" ")

arrSplit = [strLoop for strLoop in strInput.strip().split(" ") if strLoop]

## print (nSpace)
## print (arrSplit)

nStrLen = len(arrSplit)

if nStrLen == 1:
    print (arrSplit[0] + " " * nSpace)
else:
    nEqSpace = int(nSpace / (nStrLen - 1))
    nSpaceRemain = nSpace - nEqSpace * (nStrLen - 1)
    print ((" " * nEqSpace).join(arrSplit) + " " * nSpaceRemain)
