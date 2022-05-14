""" Challenge 164 Task 1 """
from sympy import nextprime


def get_palindrome_numbers() -> list:
    """Get the palindrome numbers as requested"""
    prime = 0

    output = []

    while (prime := nextprime(prime)) < 1000:
        if str(prime) == str(prime)[::-1]:
            output.append(prime)

    return output


assert get_palindrome_numbers() == [
    2,
    3,
    5,
    7,
    11,
    101,
    131,
    151,
    181,
    191,
    313,
    353,
    373,
    383,
    727,
    757,
    787,
    797,
    919,
    929,
]
