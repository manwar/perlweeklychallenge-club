## Example 1
## strInput = "dbca"
## nK = 1

## Example 2
## strInput = "geeks"
## nK = 2

## Example 3
## strInput = "cbaed"
## nK = 3

## Example 4
## strInput = "fedcba"
## nK = 4

## Example 5
## strInput = "perl"
## nK = 1

## Example 6
## strInput = "oloolooo"
## nK = 1

## Example 7
strInput = "oloooolo"
nK = 1

GetOrderStr = (lambda strGiven, nKGiven : min(strGiven[nIndx:] + strGiven[:nIndx] for nIndx in range(len(strGiven))) if nKGiven == 1 else "".join(sorted(strGiven)))

print (GetOrderStr(strInput, nK))