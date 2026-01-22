
from fractions import Fraction

## nInt = 3  ## Example 1
## nInt = 4  ## Example 2
## nInt = 1  ## Example 3
## nInt = 6  ## Example 4
nInt = 5  ## Example 5

arrList = ["{}/{}".format(objFraction.numerator, objFraction.denominator) for objFraction in sorted(set([Fraction(nNumerator, nDenominator) for nNumerator in range(1, nInt + 1) for nDenominator in range(1, nInt + 1)]))]

print (", ".join(arrList))
