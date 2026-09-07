
from chemparse import parse_formula

## strFormula = "((N2O)3(H2O)2)2"  ## Example 1
## strFormula = "Mg3(PO4)2"  ## Example 2
## strFormula = "(((H)2)3)4"  ## Example 3
## strFormula = "NaCl3(O2(S10)2)2Mg"  ## Example 4
strFormula = "W2X4Y3Z2"  ## Example 5

objElemCount = parse_formula(strFormula)

## print (objElemCount)

arrOutput = [strKey + (str(int(dCount)) if dCount > 1 else "") for strKey, dCount in sorted(objElemCount.items())]

print ("".join(arrOutput))