from typing import List


def count_arithmetic_triplets(nums: list[int], diff: int) -> int:
    count = 0
    nums_set = set(nums)

    for num in nums:
        if num + diff in nums_set and num - diff in nums_set:
            count += 1

    return count


# Test Cases
assert count_arithmetic_triplets([0, 1, 4, 6, 7, 10], 3) == 2
assert count_arithmetic_triplets([4, 5, 6, 7, 8, 9], 2) == 2
