from typing import List


def smaller_than_current(ints: list[int]) -> list[int]:
    return [sum(x < y for x in ints) for y in ints]


# Test cases
assert smaller_than_current([5, 2, 1, 6]) == [2, 1, 0, 3]
assert smaller_than_current([1, 2, 0, 3]) == [1, 2, 0, 3]
assert smaller_than_current([0, 1]) == [0, 1]
assert smaller_than_current([9, 4, 9, 2]) == [2, 1, 2, 0]
