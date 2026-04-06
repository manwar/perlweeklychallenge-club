
from sympy import primeomega, primefactors

## Example 1
## nNumber = 100061
## nMode = 0

## Example 2
## nNumber = 971088
## nMode = 0

## Example 3
## nNumber = 63640
## nMode = 1

## Example 4
## nNumber = 988841
## nMode = 1

## Example 5
nNumber = 211529
nMode = 0

print (primeomega(nNumber) if nMode == 1 else len(primefactors(nNumber)))
