
def GetGoalParser (strText):
    return strText.replace("()", "o").replace("(al)", "al")

## strInput = "G()(al)"  ## Example 1
## strInput = "G()()()()(al)"  ## Example 2
## strInput = "(al)G(al)()()"  ## Example 3
## strInput = "()G()G"  ## Example 4
strInput = "(al)(al)G()()"  ## Example 5

print (GetGoalParser(strInput))
