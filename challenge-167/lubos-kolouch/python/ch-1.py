""" Chalenge 167 Task 1 Python"""

from sympy import isprime, nextprime


def is_circular_prime(prime: int) -> bool:
    """
    Checks if a prime number is circular prime.
    """
    prime_str = str(prime)
    for i in range(len(prime_str)):
        if not isprime(int(prime_str[i:] + prime_str[:i])):
            return False
    return True


def generate_primes(limit: int) -> list:
    """
    Generates all prime numbers below a limit.
    """

    primes: list = []
    prime = nextprime(100)

    while len(primes) < limit:
        if is_circular_prime(prime):
            primes.append(prime)

        prime = nextprime(prime)

    return primes


assert is_circular_prime(2) == 1
assert is_circular_prime(3) == 1
assert is_circular_prime(11) == 1
assert is_circular_prime(13) == 1
assert is_circular_prime(57) == 0
assert is_circular_prime(197) == 1

# Note that the example given on the challenge is wrong according to
# https://oeis.org/A068652

assert generate_primes(10) == [113, 131, 197, 199, 311, 337, 373, 719, 733, 919]
