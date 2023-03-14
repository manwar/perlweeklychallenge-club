#!/usr/bin/env python3
"""
remove_leading_zeros - removes leading zeros from positive numbers
"""

import re
import unittest


def remove_leading_zeros(num: str) -> str:
    """
    Removes leading zeros from the positive number in `num` and returns the result.

    Args:
        num: A string containing a positive number with leading zeros.

    Returns:
        A string with the number in `num` with leading zeros removed.
    """
    return re.sub(r'^0+(?!$)', '', num)


class TestRemoveLeadingZeros(unittest.TestCase):

    def test_remove_leading_zeros(self):
        self.assertEqual(remove_leading_zeros("0001234"), "1234")
        self.assertEqual(remove_leading_zeros("000"), "0")
        self.assertEqual(remove_leading_zeros("0"), "0")


if __name__ == '__main__':
    unittest.main()
