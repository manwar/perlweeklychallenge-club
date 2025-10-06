
## strInput = "a0b1c2"  ## Example 1
## strInput = "abc12"  ## Example 2
## strInput = "0a2b1c3"  ## Example 3
## strInput = "1a23"  ## Example 4
strInput = "ab123"  ## Example 5

arrChar = list(strInput)
arrAlpha = sorted([charLoop for charLoop in arrChar if charLoop.isalpha()])
arrNum = sorted([charLoop for charLoop in arrChar if charLoop.isdigit()])

if abs(len(arrAlpha) - len(arrNum)) > 1:
    print ("")
elif len(arrAlpha) == len(arrNum):
    print ("".join([numLoop + charLoop for numLoop, charLoop in zip(arrNum, arrAlpha)]))
elif len(arrAlpha) < len(arrNum):
    print ("".join([numLoop + charLoop for numLoop, charLoop in zip(arrNum[:-1], arrAlpha)]) + arrNum[-1])
else:
    print ("".join([charLoop + numLoop for charLoop, numLoop in zip(arrAlpha[:-1], arrNum)]) + arrAlpha[-1])
