""" Challenge 267 Task 1 LK Python"""

from typing import List


def product_sign(ints: List[int]) -> int:
    """
    Computes the sign of the product of a list of integers.

    Args:
    ints (List[int]): A list of integers.

    Returns:
    int: The sign of the product of the integers (1, -1, or 0).
    """
    negative_count = 0
    for value in ints:
        if value == 0:
            return 0
        elif value < 0:
            negative_count += 1

    return -1 if negative_count % 2 != 0 else 1


# Test cases
assert product_sign([-1, -2, -3, -4, 3, 2, 1]) == 1
assert product_sign([1, 2, 0, -2, -1]) == 0
assert product_sign([-1, -1, 1, -1, 2]) == -1

print(product_sign([-1, -2, -3, -4, 3, 2, 1]))  # Output: 1
print(product_sign([1, 2, 0, -2, -1]))  # Output: 0
print(product_sign([-1, -1, 1, -1, 2]))  # Output: -1
