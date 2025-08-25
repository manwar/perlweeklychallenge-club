
from math import gcd

## arrInt = [1, 1, 2, 2, 2, 2]  ## Example 1
## arrInt = [1, 1, 1, 2, 2, 2, 3, 3]  ## Example 2
## arrInt = [5, 5, 5, 5, 5, 5, 7, 7, 7, 7, 7, 7]  ## Example 3
## arrInt = [1, 2, 3, 4]  ## Example 4
arrInt = [8, 8, 9, 9, 10, 10, 11, 11]  ## Example 5

arrCount = [arrInt.count(nElem) for nElem in set(arrInt)]

nGCD = gcd(*arrCount) 

print (nGCD > 1)
