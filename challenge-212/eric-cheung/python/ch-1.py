
## Example 1
## strWordInput = "Perl"
## arrJumpStep = [2, 22, 19, 9]

## Example 2
strWordInput = "Raku"
arrJumpStep = [24, 4, 7, 17]

arrOuputChar = []

for nIndx, charLoop in enumerate(strWordInput):

    bIsUpper = charLoop.isupper()
    nJumpChar = ord(charLoop) + arrJumpStep[nIndx]

    if nJumpChar > ord("Z" if bIsUpper else "z"):
        nJumpChar = nJumpChar % ord("Z" if bIsUpper else "z") + ord("A" if bIsUpper else "a") - 1

    arrOuputChar.append(chr(nJumpChar))

print ("".join(arrOuputChar))
