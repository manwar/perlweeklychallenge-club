from math import sqrt
from more_itertools import partitions


def is_split_number(what: int):
    """ check if the number is split """
    sqr = int(sqrt(what))

    for comb in partitions(str(what)):
        result = 0
        for item in comb:
            result += int(''.join(item))
        if result == sqr:
            return 1

    return 0


assert is_split_number(81) == 1
assert is_split_number(9801) == 1
assert is_split_number(36) == 0
