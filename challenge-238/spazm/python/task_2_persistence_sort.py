#!/usr/bin/env python3


def persistence_sort(ints: list[int]) -> list[int]:
    """
    You are given an array of positive integers.

    Write a script to sort the given array in increasing order with respect to
    the count of steps required to obtain a single-digit number by multiplying
    its digits recursively for each array element. If any two numbers have the
    same count of steps, then print the smaller number first.

    Example 1
    Input: @int = (15, 99, 1, 34)
    Output: (1, 15, 34, 99)

    >>> persistence_sort([15, 99, 1, 34]) == [1, 15, 34, 99]

    15 => 1 x 5 => 5 (1 step)
    99 => 9 x 9 => 81 => 8 x 1 => 8 (2 steps)
    1  => 0 step
    34 => 3 x 4 => 12 => 1 x 2 => 2 (2 steps)
    Example 2
    Input: @int = (50, 25, 33, 22)
    Output: (22, 33, 50, 25)

    50 => 5 x 0 => 0 (1 step)
    25 => 2 x 5 => 10 => 1 x 0 => 0 (2 steps)
    33 => 3 x 3 => 9 (1 step)
    22 => 2 x 2 => 4 (1 step)
    """

    return sorted(ints, key=persistence_sort_key)


def persistence_sort_key(x):
    steps_x = single_digit_multiplication_steps(x)
    return (steps_x, x)


def single_digit_multiplication_steps(num: int) -> int:
    """
    Given a multiple-digit number, multiply its digits recursively and return
    the number of steps required to obtain a single-digit number.

    >>> single_digit_multiplication_steps(50) == 1
    >>> single_digit_multiplication_steps(25) == 2
    >>> single_digit_multiplication_steps(33) == 1
    >>> single_digit_multiplication_steps(22) == 1
    >>> single_digit_multiplication_steps(99) == 2
    >>> single_digit_multiplication_steps(81) == 1
    >>> single_digit_multiplication_steps(14) == 1
    >>> single_digit_multiplication_steps(98) == 3
    >>> single_digit_multiplication_steps(72) == 2
    >>> single_digit_multiplication_steps(14) == 1
    """

    product = 1
    for digit in str(num):
        product *= int(digit)

    if product < 10:
        return 1
    else:
        return 1 + single_digit_multiplication_steps(product)


if __name__ == "__main__":
    import unittest

    tester = unittest.TestCase()

    multiplication_steps_tests = [
        (50, 1),
        (25, 2),
        (33, 1),
        (22, 1),
        (99, 2),
        (81, 1),
        (98, 3),
        (72, 2),
        (14, 1),
    ]
    for input, expected in multiplication_steps_tests:
        tester.assertEqual(
            expected, single_digit_multiplication_steps(input), f"input: {input}"
        )

    persistence_sort_tests = [([15, 99, 1, 34], [1, 15, 34, 99])]
    for input, expected in persistence_sort_tests:
        tester.assertEqual(expected, persistence_sort(input), f"input: {input}")
