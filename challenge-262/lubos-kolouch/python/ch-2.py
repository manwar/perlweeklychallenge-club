from typing import List


def count_equal_divisible(ints: List[int], k: int) -> int:
    count = 0
    n = len(ints)
    for i in range(n):
        for j in range(i + 1, n):
            if ints[i] == ints[j] and i * j % k == 0:
                count += 1
    return count


# Assert tests
assert count_equal_divisible([3, 1, 2, 2, 2, 1, 3], 2) == 4
assert count_equal_divisible([1, 2, 3], 1) == 0
