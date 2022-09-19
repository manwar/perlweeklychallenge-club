##

## strInput = "Perl Weekly Challenge" ## Example 1
strInput = "Long Live Perl" ## Example 2

for nIndex in range(0, len(strInput)):

    ## print (strInput[nIndex])
    if strInput.count(strInput[nIndex]) == 1:
        print (nIndex)

        break
