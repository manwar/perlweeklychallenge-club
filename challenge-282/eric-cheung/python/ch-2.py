
## strInput = "pPeERrLl"  ## Example 1
## strInput = "rRr"  ## Example 2
strInput = "GoO"  ## Example 3

arrCount = [0 if strInput[nIndx].lower() == strInput[nIndx + 1].lower() else 1 for nIndx in range(len(strInput) - 1)]

print (sum(arrCount))
