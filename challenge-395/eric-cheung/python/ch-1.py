
## Example 1
## strNum_01 = "1+1i"
## strNum_02 = "1+1i"

## Example 2
## strNum_01 = "1-i"
## strNum_02 = "1-i"

## Example 3
## strNum_01 = "0+3i"
## strNum_02 = "0+4i"

## Example 4
## strNum_01 = "3+4i"
## strNum_02 = "3-4i"

## Example 5
strNum_01 = "50-20i"
strNum_02 = "-10+30i"

objComplex_01 = complex(strNum_01.replace("i", "j"))
objComplex_02 = complex(strNum_02.replace("i", "j"))

objComplexRes = objComplex_01 * objComplex_02

print (objComplexRes)
