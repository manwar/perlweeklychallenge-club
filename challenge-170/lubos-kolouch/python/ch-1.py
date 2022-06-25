""" Challenge 170 Task 1 """
from sympy import nextprime


def gen_primorial_nums(count: int) -> list:
    """Generate the primorial numbers"""

    nums = [1]
    at_prime = 1

    while len(nums) < count:
        at_prime = nextprime(at_prime)

        nums.append(nums[-1] * at_prime)

    return nums


assert gen_primorial_nums(3) == [1, 2, 6]
assert gen_primorial_nums(10) == [
    1,
    2,
    6,
    30,
    210,
    2310,
    30030,
    510510,
    9699690,
    223092870,
]
