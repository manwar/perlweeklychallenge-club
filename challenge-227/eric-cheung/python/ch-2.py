
import roman

nMaxLimit = 3999

def GetRomanArithOper (strInput):

    global nMaxLimit

    arrElem = strInput.split()
    nInt_01 = roman.fromRoman(arrElem[0])
    strOperator = arrElem[1]
    nInt_02 = roman.fromRoman(arrElem[2])

    if strOperator == "+":
        if nInt_01 + nInt_02 > nMaxLimit:
            return "non potest"
        return roman.toRoman(nInt_01 + nInt_02)

    if strOperator == "-":
        if nInt_01 > nInt_02:
            return roman.toRoman(nInt_01 - nInt_02)
        if nInt_01 == nInt_02:
            return "nulla"
        return "non potest"

    if strOperator == "/":
        if nInt_01 % nInt_02 == 0:
            return roman.toRoman(int(nInt_01 / nInt_02))
        return "non potest"

    if strOperator == "*":
        if nInt_01 * nInt_02 > nMaxLimit:
            return "non potest"
        return roman.toRoman(nInt_01 * nInt_02)

    if strOperator == "**":
        if nInt_01 ** nInt_02 > nMaxLimit:
            return "non potest"
        return roman.toRoman(nInt_01 ** nInt_02)


## strGivenExpr = "IV + V"
## strGivenExpr = "M - I"
## strGivenExpr = "X / II"
## strGivenExpr = "XI * VI"
## strGivenExpr = "VII ** III"
## strGivenExpr = "V - V"
## strGivenExpr = "V / II"
## strGivenExpr = "MMM + M"
strGivenExpr = "V - X"

print (GetRomanArithOper(strGivenExpr))
