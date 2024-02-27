#!/usr/bin/env python

from typing import Tuple


def count_even_digits(ints: tuple[int, ...]) -> int:
    """
    Counts the number of integers in the given tuple that have an even number of digits.

    Parameters:
    ints (Tuple[int, ...]): A tuple of positive integers.

    Returns:
    int: The count of integers with an even number of digits.
    """
    even_digits_count = 0
    for num in ints:
        if len(str(num)) % 2 == 0:
            even_digits_count += 1
    return even_digits_count


# Assert tests
assert count_even_digits((10, 1, 111, 24, 1000)) == 3, "Test Case  1 Failed"
assert count_even_digits((111, 1, 11111)) == 0, "Test Case  2 Failed"
assert count_even_digits((2, 8, 1024, 256)) == 1, "Test Case  3 Failed"

# Example usage
print(count_even_digits((10, 1, 111, 24, 1000)))  # Output:  3
print(count_even_digits((111, 1, 11111)))  # Output:  0
print(count_even_digits((2, 8, 1024, 256)))  # Output:  1
