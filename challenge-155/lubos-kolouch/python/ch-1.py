""" Challenge 155 LK Python Task 1"""
from sympy import isprime, nextprime


def get_pn(what: int) -> int:
    """Get the pn needed for the formula"""
    last_num = 1
    pn = 1

    for _ in range(1, what + 1):
        last_num = nextprime(last_num)

        pn *= last_num
    return pn


def find_fortunate_num(what: int) -> int:
    """Find the respective fortunate number"""

    num = 2
    while not isprime(what + num):
        num += 1

    return num


def get_n_fortunate_nums(what: int) -> list:
    """Find the task solution"""

    fortunate_nums = []

    # * 2 number should be more than enough
    for i in range(1, what * 2):
        pn = get_pn(i)

        fortunate = find_fortunate_num(pn)
        fortunate_nums.append(fortunate)

    fortunate_nums = list(sorted(set(fortunate_nums)))
    return fortunate_nums[0 : what + 1]


assert get_n_fortunate_nums(7) == [3, 5, 7, 13, 17, 19, 23, 37]
