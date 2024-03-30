from typing import List


def max_positive_negative(ints: List[int]) -> int:
    positive_count = sum(1 for x in ints if x > 0)
    negative_count = sum(1 for x in ints if x < 0)
    return max(positive_count, negative_count)


# Assert tests
assert max_positive_negative([-3, 1, 2, -1, 3, -2, 4]) == 4
assert max_positive_negative([-1, -2, -3, 1]) == 3
assert max_positive_negative([1, 2]) == 2
