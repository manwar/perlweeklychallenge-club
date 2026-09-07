
from fractions import Fraction

def ConvRecToFrac (strInput):
    strNum = strInput.replace("(", "").replace(")", "")

    nPosOpenBracket = strInput.find("(")
    nPosCloseBracket = strInput.find(")")

    nFac = 10 ** (nPosCloseBracket - nPosOpenBracket - 1)
    nNom = int(float(strNum) * nFac)
    nDen = nFac - 1

    return Fraction(f"{nNom}/{nDen}")

## Example 1
## strRat_01 = "0.(12)"
## strRat_02 = "0.(121)"

## Example 2
## strRat_01 = "0.1(23)"
## strRat_02 = "0.12(32)"

## Example 3
## strRat_01 = "0.1(234)"
## strRat_02 = "0.12(342)"

## Example 4
## strRat_01 = "12.99(99)"
## strRat_02 = "13."

## Example 5
strRat_01 = "0.(123)"
strRat_02 = "0.1(231)"

objFrac_01 = ConvRecToFrac(strRat_01)
objFrac_02 = ConvRecToFrac(strRat_02)

print (objFrac_01 == objFrac_02)