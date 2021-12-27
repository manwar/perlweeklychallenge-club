## Calculator
import os

strMathExpr = "10 + 20 - 5" ## Example 1
## strMathExpr = "(10 + 20 - 5) * 2" ## Example 2

print (strMathExpr + " = " + str(eval(strMathExpr)))

os.system("pause")
