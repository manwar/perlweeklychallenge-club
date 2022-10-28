"""Perl weekly challenge 188 - Task #2: Total Zero

You are given two positive integers $x and $y.
Write a script to find out the number of operations needed to make both ZERO.
Each operation is made up either of
'$x = $x - $y if $x >= $y'
or
'$y = $y - $x if $y >= $x (using the original value of $x)'.

https://theweeklychallenge.org/blog/perl-weekly-challenge-188/#TASK2
"""
import unittest


def total_zero(x: int, y: int) -> int:
    """Calculate number of operations needed to make both given vales zero.

    Operations: x = x - y, if x >= y or y = y - x if y >= x
    (using the original value of x).

    :param x: initial x val
    :param y: initial y val
    :return: total operations needed to make both ZERO
    """
    total = 0
    while x > 0 and y > 0:
        new_x, new_y = x, y
        if x >= y:
            count, new_x = divmod(x, y)
            total += count

        if y >= x:
            count, new_y = divmod(y, x)
            total += count

        x, y = new_x, new_y

    return total


class TestTotalZero(unittest.TestCase):

    def test_total_zero(self):
        cases = (
            ((5, 4), 5),
            ((4, 6), 3),
            ((2, 5), 4),
            ((3, 1), 3),
            ((7, 4), 5),
        )
        for case in cases:
            self.assertEqual(total_zero(*case[0]), case[1], f"Input: {case[0]}")


if __name__ == '__main__':
    unittest.main()
