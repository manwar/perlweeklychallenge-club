
## Example 1
## strInput_01 = "uvw"
## strInput_02 = "bcudvew"

## Example 2
## strInput_01 = "aec"
## strInput_02 = "abcde"

## Example 3
strInput_01 = "sip"
strInput_02 = "javascript"

bIsSubSeq = True
bLastIndx = -1
for nIndx, charLoop in enumerate(strInput_01):
    if charLoop not in strInput_02:
        bIsSubSeq = False
        break

    if strInput_02.index(charLoop) < bLastIndx:
        bIsSubSeq = False
        break

    bLastIndx = strInput_02.index(charLoop)

print (bIsSubSeq)
