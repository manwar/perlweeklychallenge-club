
import sys

## Example 1
## strInput = "Perl"
## strCheck = "Preel"

## Example 2
## strInput = "Weekly"
## strCheck = "Weeakly"

## Example 3
strInput = "Box"
strCheck = "Boxy"

arrUniqCharInput = list(set(strInput))
arrCharInputCount = [strInput.count(charLoop) for charLoop in arrUniqCharInput]

arrUniqCharCheck = list(set(strCheck))
arrUniqCheck = [strCheck.count(charLoop) for charLoop in arrUniqCharCheck]

for nIndx, charLoop in enumerate(arrUniqCharCheck):
    if charLoop not in arrUniqCharInput:
        print (charLoop)
        sys.exit()

    if arrUniqCheck[nIndx] > arrCharInputCount[arrUniqCharInput.index(charLoop)]:
        print (charLoop)
        sys.exit()
