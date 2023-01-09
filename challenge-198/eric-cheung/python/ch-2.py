
from sympy import isprime

## nInput = 10  ## Example 1
## nInput = 15  ## Example 2
## nInput = 1  ## Example 3
nInput = 25  ## Example 4

arrPrime = [nLoop for nLoop in range(2, nInput) if isprime(nLoop)]

print (len(arrPrime))
