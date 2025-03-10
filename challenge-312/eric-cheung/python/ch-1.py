
## strInput = "abc"  ## Example 1
## strInput = "bza"  ## Example 2
strInput = "zjpc"  ## Example 3

nStep = 0

for nIndx, charLoop in enumerate(strInput):
    charCurLoop = charLoop
    charPrvLoop = (strInput[nIndx - 1] if nIndx > 0 else "a")

    nStep = nStep + 1
    nStep = nStep + min((ord(charCurLoop) - ord(charPrvLoop) + 26) % 26, (ord(charPrvLoop) - ord(charCurLoop) + 26) % 26)

    ## print ("")
    ## print ("==")
    ## print (charCurLoop, charPrvLoop)
    ## print ((ord(charCurLoop) - ord(charPrvLoop) + 26) % 26)
    ## print ((ord(charPrvLoop) - ord(charCurLoop) + 26) % 26)
    ## print ("==")

print (nStep)
