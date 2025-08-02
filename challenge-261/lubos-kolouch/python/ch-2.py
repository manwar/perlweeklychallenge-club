from typing import List


def multiply_by_two(ints: List[int], start: int) -> int:
    ints_set = set(ints)

    while start in ints_set:
        start *= 2

    return start


# Test cases
assert multiply_by_two([5, 3, 6, 1, 12], 3) == 24, "Test Case 1"
assert multiply_by_two([1, 2, 4, 3], 1) == 8, "Test Case 2"
assert multiply_by_two([5, 6, 7], 2) == 2, "Test Case 3"
