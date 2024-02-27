#!/usr/bin/env python

from typing import List


def sum_of_values(ints: list[int], k: int) -> int:
    """
    Calculates the sum of values in the given list whose indices have exactly k  1-bits in their binary representation.

    :param ints: A list of integers.
    :param k: The number of  1-bits in the binary representation of the index.
    :return: The sum of values whose indices have exactly k  1-bits.
    """
    total_sum = 0
    for i, value in enumerate(ints):
        if bin(i).count("1") == k:
            total_sum += value
    return total_sum


# Test cases
def test_sum_of_values():
    assert sum_of_values([2, 5, 9, 11, 3], 1) == 17
    assert sum_of_values([2, 5, 9, 11, 3], 2) == 11
    assert sum_of_values([2, 5, 9, 11, 3], 0) == 2
    print("All tests passed.")


if __name__ == "__main__":
    test_sum_of_values()
