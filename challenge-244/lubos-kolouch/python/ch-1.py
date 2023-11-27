from typing import List


def count_smaller(nums: list[int]) -> list[int]:
    """
    Count the number of elements smaller than the current element at each index.

    Args:
    nums (List[int]): An array of integers.

    Returns:
    List[int]: An array containing the counts.
    """
    n = len(nums)
    result = []
    for i in range(n):
        count = sum(1 for j in range(n) if nums[j] < nums[i] and j != i)
        result.append(count)
    return result


# Tests
assert count_smaller([8, 1, 2, 2, 3]) == [4, 0, 1, 1, 3]
assert count_smaller([6, 5, 4, 8]) == [2, 1, 0, 3]
assert count_smaller([2, 2, 2]) == [0, 0, 0]
