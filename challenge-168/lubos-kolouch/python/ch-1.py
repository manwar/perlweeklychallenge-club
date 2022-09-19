""" Challenge 168 Task 1 LK Python """

from sympy import isprime


def generate_perrin_primes(n: int) -> list:
    """
    Generate all primes up to n using the Perrin sequence.
    """
    perrin_sequence = [3, 0, 2]

    perrin_primes: dict = {}

    while len(perrin_primes.keys()) < n:

        next_number = perrin_sequence[-3] + perrin_sequence[-2]
        perrin_sequence.append(next_number)

        if isprime(next_number):
            perrin_primes[next_number] = True

    return sorted(perrin_primes.keys())


assert generate_perrin_primes(13) == [
    2,
    3,
    5,
    7,
    17,
    29,
    277,
    367,
    853,
    14197,
    43721,
    1442968193,
    792606555396977,
]
