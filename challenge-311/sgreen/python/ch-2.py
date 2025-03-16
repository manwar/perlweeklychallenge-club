#!/usr/bin/env python3

import sys


def group_digit_sum(s: str, i: int) -> int:
    """Calculate the sum of each group of "i" character concatenated until such
    point that the sum if "i" digits or less.

    Args:
        s (str): The string
        i (int): The size of each group

    Returns:
        int: The sum of each group of strings
    """

    # Group the input into 'i' characters
    groups = [s[x:x+i] for x in range(0, len(s), i)]

    # Sum each group of digits
    sums = ''
    for group in groups:
        sums += str(sum(int(d) for d in group))

    # If the new sum is longer than i digits, call the function again
    if len(sums) > i:
        return group_digit_sum(sums, i)

    # Return the sum as an integer
    return int(sums)


def main():
    result = group_digit_sum(sys.argv[1], int(sys.argv[2]))
    print(result)


if __name__ == '__main__':
    main()
