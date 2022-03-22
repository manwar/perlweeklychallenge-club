""" Challenge 156 Task 2 LK """
from itertools import combinations

from sympy import divisors


def is_weird(what: int) -> bool:
    """Check if the number is weird"""

    all_divisors = divisors(what)

    # remove the number itself from the list
    del all_divisors[-1]

    if sum(all_divisors) <= what:
        return False

    for i in range(1, len(all_divisors) + 1):
        all_combs = combinations(all_divisors, i)
        for comb in all_combs:
            if sum(comb) == what:
                return False
    return True


assert is_weird(12) == 0
assert is_weird(70) == 1
