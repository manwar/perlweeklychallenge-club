# Challenge 158 Task 1
from sympy import isprime, nextprime


def get_additive_primes(limit: int) -> list:
    """Get the list of primes"""

    pos = 1
    primes = []

    while pos <= limit:

        if isprime(pos) and isprime(sum(list(map(int, str(pos))))):
            primes.append(pos)

        pos = nextprime(pos)

    return primes


assert get_additive_primes(100) == [2, 3, 5, 7, 11, 23, 29, 41, 43, 47, 61, 67, 83, 89]
