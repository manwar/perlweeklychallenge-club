
## strInput = "weekly"  ## Example 1
## strInput = "perl"  ## Example 2
strInput = "challenge"  ## Example 3

arrSet = [charLoop for charLoop in set(strInput) if strInput.count(charLoop) % 2 == 0]

print (len(arrSet) == 0)
