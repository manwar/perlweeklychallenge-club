from itertools import accumulate
from typing import List


def running_sum(nums: list[int]) -> list[int]:
    return list(accumulate(nums))


# Test cases
print(running_sum([1, 2, 3, 4, 5]))  # Output should be [1, 3, 6, 10, 15]
print(running_sum([1, 1, 1, 1, 1]))  # Output should be [1, 2, 3, 4, 5]
print(running_sum([0, -1, 1, 2]))  # Output should be [0, -1, 0, 2]
