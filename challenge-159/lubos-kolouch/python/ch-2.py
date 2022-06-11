""" Challenge 159 Task 2"""
from sympy.ntheory import factorint


def get_moebius_nr(what: int):
    """Get the moebius nr"""
    factors = factorint(what)

    if any(value > 1 for value in factors.values()):
        return 0

    if len(factors) % 2 == 0:
        return 1

    return -1


assert get_moebius_nr(5) == -1
assert get_moebius_nr(10) == 1
assert get_moebius_nr(20) == 0
