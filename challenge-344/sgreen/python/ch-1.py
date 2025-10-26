#!/usr/bin/env python3

import sys


def array_form_compute(ints: list[int], x: int) -> list[int]:
    """Compute the array-form of an integer after adding x.

    Args:
        ints: A list of single digit integers.
        x: A non-negative integer to add to the integer represented by ints.

    Returns:
        A list of single digit integers representing the array-form of the resulting integer.
    """

    # Check the list is single digit integers
    if any(not isinstance(n, int) or n < 0 or n > 9 for n in ints):
        raise ValueError(
            "All elements in the list must be single digit integers (0-9)."
        )

    # Check x is a non-negative integer
    if x < 0:
        raise ValueError("The integer x must be a non-negative integer.")

    for pos in range(len(ints) - 1, 0, -1):
        i = ints[pos]

        # Split x into the carry forward and the last digit
        x, remainder = divmod(x, 10)

        # Add the remainder to the digit at the current position
        # However we may need to carry forward if the new digit is >= 10
        add_x, add_i = divmod(i + remainder, 10)
        ints[pos] = add_i
        x += add_x

    # Handle the most significant digit
    ints[0] += x
    if ints[0] >= 10:
        # We need to split this into separate digits
        digits = map(int, str(ints[0]))
        ints = list(digits) + ints[1:]

    return ints


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = array_form_compute(array[:-1], array[-1])
    print(result)


if __name__ == '__main__':
    main()
