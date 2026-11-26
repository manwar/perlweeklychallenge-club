
from fractions import Fraction
import re

def GetFractionAddition(strExprInput):
    objTokens = re.findall(r"[+-]?\d+/\d+", strExprInput)
    objTotal = sum(Fraction(objToken) for objToken in objTokens)
    return f"{objTotal.numerator}/{objTotal.denominator}"

## strExpr = "1/2+3/2"  ## Example 1
## strExpr = "-5/2-3/2"  ## Example 2
## strExpr = "5/3-5/3"  ## Example 3
## strExpr = "10/10-1/10+2/5"  ## Example 4
strExpr = "1/6+1/6+1/6"  ## Example 5

print (GetFractionAddition(strExpr))