""" Challenge 156 Task 1 LK """
import re

from sympy import isprime


def get_pernicious(what: int) -> list:
    """Get the pernicious numbers"""

    nums: list[int] = []

    num = 0
    while len(nums) < what:
        num += 1
        bin_num = f"{num:b}"
        bin_num = re.sub("0", "", bin_num)
        if isprime(len(bin_num)):
            nums.append(num)
    return nums


assert get_pernicious(10) == [3, 5, 6, 7, 9, 10, 11, 12, 13, 14]
