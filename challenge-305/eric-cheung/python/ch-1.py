
from sympy import isprime

## arrBinary = [1,  0,  1]  ## Example 1
## arrBinary = [1, 1, 0]  ## Example 2
arrBinary = [1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1]  ## Example 3

arrStrBinary = [str(nElem) for nElem in arrBinary]
arrOutput = [False]

## for nIndx in range(1, len(arrStrBinary)):
    ## arrOutput.append(isprime(int("".join(arrStrBinary[ : nIndx + 1]), 2)))

arrOutput = arrOutput + [isprime(int("".join(arrStrBinary[ : nIndx + 1]), 2)) for nIndx in range(1, len(arrStrBinary))]

print (arrOutput)
