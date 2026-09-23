#!/usr/bin/env python3
"""Perl Weekly Challenge 031 - Task 1: Check Divide by Zero Error.

Create a function to check divide by zero error without checking if
the denominator is zero.
"""

from typing import Union
import unittest


def check_divide(num: Union[int, float], div: Union[int, float]) -> Union[float, str]:
    """Divide num by div without checking if div == 0, catching ZeroDivisionError.

    Args:
        num: The numerator.
        div: The denominator.

    Returns:
        The result of division or 'error' if ZeroDivisionError occurred.
    """
    try:
        return num / div
    except ZeroDivisionError:
        return "error"


class TestCheckDivide(unittest.TestCase):
    """Test suite for check_divide."""

    def test_divide_by_zero(self) -> None:
        """Test divide by zero cases."""
        self.assertEqual(check_divide(1, 0), "error")
        self.assertEqual(check_divide(0, 0), "error")
        self.assertEqual(check_divide(-5, 0), "error")

    def test_valid_division(self) -> None:
        """Test standard division cases."""
        self.assertEqual(check_divide(4, 2), 2.0)
        self.assertEqual(check_divide(3, 4), 0.75)
        self.assertEqual(check_divide(0, 1), 0.0)


if __name__ == "__main__":
    unittest.main()
