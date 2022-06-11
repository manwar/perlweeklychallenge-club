## Credit:
## https://rosettacode.org/wiki/Fortunate_numbers#Python

from sympy.ntheory.generate import primorial
from sympy.ntheory import isprime

def fortunate_number(nInput):
    ## Return the fortunate number for positive integer nInput
    ## Since primorial(nInput) is even for all positive integers nInput,
    ## it suffices to search for the fortunate numbers among odd integers.
    nLoop = 3
    primorial_ = primorial(nInput)
    while True:
        if isprime(primorial_ + nLoop):
            return nLoop

        nLoop = nLoop + 2

fortunate_numbers = set()

for nLoop in range(1, 76):
    fortunate_numbers.add(fortunate_number(nLoop))

# Extract the first 8 numbers.
arrNum = sorted(list(fortunate_numbers))[:8]

print('The first 8 fortunate numbers:')
print(('{:<3} ' * 10).format(*(arrNum[:])))
