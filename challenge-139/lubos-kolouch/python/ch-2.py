import re
from sympy import nextprime
import decimal


def get_repeating_pattern(what):

    with decimal.localcontext() as ctx:
        ctx.prec = 100
        big_reverse = str(decimal.Decimal(1) / decimal.Decimal(what))

    repeating = re.findall(r'(.+?)\1', big_reverse)

    try:
        return len(repeating[0])
    except IndexError:
        return 0


def is_long_prime(what):

    repeats = get_repeating_pattern(what)

    if repeats > 1 and repeats == what - 1:
        return 1

    return 0


def generate_long_primes():
    """ Generate the primes for the challenge """

    primes_count = 0
    at_prime = 0

    result = []

    while primes_count < 5:
        at_prime = nextprime(at_prime)

        if is_long_prime(at_prime):
            primes_count += 1
            result.append(at_prime)

    return result


assert get_repeating_pattern(7) == 6
assert get_repeating_pattern(17) == 16

assert is_long_prime(7) == 1
assert is_long_prime(17) == 1
assert is_long_prime(2) == 0
assert generate_long_primes() == [7, 17, 19, 23, 29]
