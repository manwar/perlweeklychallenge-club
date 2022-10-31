#!/usr/bin/env python

"""
You are given two positive integers $x and $y.

Write a script to find out the number of operations needed to make both ZERO. Each operation is made up either of the followings:

$x = $x - $y if $x >= $y

or

$y = $y - $x if $y >= $x (using the original value of $x)
"""


def total_zero(x, y):
    count = 0
    assert x == int(x) and y == int(y)
    while True:
        count += 1
        if x > y:
            x -= y
        elif y > x:
            y -= x
        else:
            return count
    return


def total_zero_recursive(x, y):
    return 1 + (
        total_zero_recursive(x - y, y)
        if x > y
        else total_zero_recursive(x, y - x)
        if y > x
        else 0
    )


if __name__ == "__main__":
    test_data = [
        [[5, 4], 5],
        [[4, 6], 3],
        [[2, 5], 4],
        [[3, 1], 3],
        [[7, 4], 5],
    ]

    for (x, y), expected in test_data:
        print(f"# x: {x}, y: {y}, expected:{expected}")
        val = total_zero_recursive(x, y)
        assert val == expected, f"{val} == expected {expected}"
        val = total_zero(x, y)
        assert val == expected, f"{val} == expected {expected}"
