
## strInput = "aaaaa77777"  ## Example 1
## strInput = "abcde"  ## Example 2
## strInput = "9zero8eight7seven9"  ## Example 3
## strInput = "xyz9876543210"  ## Example 4
strInput = "4abc4def2ghi8jkl2"  ## Example 5

arrOutput = sorted([charLoop for charLoop in set(list(strInput)) if charLoop.isnumeric()], reverse = True)

print (arrOutput[1] if len(arrOutput) > 1 else -1)
