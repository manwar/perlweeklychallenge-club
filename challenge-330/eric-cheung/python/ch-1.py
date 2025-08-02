
## strInput = "cab12"  ## Example 1
## strInput = "xy99"  ## Example 2
strInput = "pa1erl"  ## Example 3

arrInput = list(strInput)

while len([charLoop for charLoop in arrInput if charLoop.isdigit()]) > 0:
    nFirstNumDigit = [nIndx for nIndx, charLoop in enumerate(arrInput) if charLoop.isdigit()][0]
    if nFirstNumDigit == 0:
        break

    del arrInput[nFirstNumDigit]
    del arrInput[nFirstNumDigit - 1]

print ("".join(arrInput))
