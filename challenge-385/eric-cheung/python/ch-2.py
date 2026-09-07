
## By AI

def GetRemoveOutermostParentheses(strInput):
    arrResult = []
    nOpened = 0

    for charLoop in strInput:
        if charLoop == "(":
            ## Only add "(" if it's not the outermost opening parenthesis
            if nOpened > 0:
                arrResult.append(charLoop)
            nOpened = nOpened + 1
        elif charLoop == ")":
            nOpened = nOpened - 1
            ## Only add ")" if it's not the outermost closing parenthesis
            if nOpened > 0:
                arrResult.append(charLoop)

    return "".join(arrResult)

## strInput = "()()()"  ## Example 1
## strInput = "(((())))"  ## Example 2
## strInput = "(()())(())"  ## Example 3
## strInput = "()((()))()"  ## Example 4
strInput = "(()(()))(()())"  ## Example 5

print (GetRemoveOutermostParentheses(strInput))