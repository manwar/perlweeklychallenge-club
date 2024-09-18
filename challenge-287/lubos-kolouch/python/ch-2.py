import re
from typing import Any
import unittest


def is_valid_number(s: str) -> bool:
    """
    Determines if the given string is a valid number based on specific rules.

    A valid number is defined as:
    - An integer number followed by an optional exponent.
    - A decimal number followed by an optional exponent.

    An integer number is defined with an optional sign '-' or '+' followed by digits.

    Decimal Number:
    - An optional sign '-' or '+' followed by one of the following:
        - Digits followed by a dot '.'.
        - Digits followed by a dot '.' followed by digits.
        - A dot '.' followed by digits.

    Exponent:
    - An exponent is defined with an exponent notation 'e' or 'E' followed by an integer number.

    Args:
        s (str): The input string.

    Returns:
        bool: True if the string is a valid number, False otherwise.
    """
    pattern = r"""
        ^                       # Start of string
        [+-]?                   # Optional sign
        (
            (                   # Decimal numbers
                \d+\.\d*        # Digits followed by dot and optional digits
                |
                \.\d+           # Dot followed by digits
                |
                \d+\.           # Digits followed by dot
            )
            |
            \d+                 # Integer numbers
        )
        ([eE][+-]?\d+)?         # Optional exponent
        $                       # End of string
    """
    regex = re.compile(pattern, re.VERBOSE)
    return bool(regex.match(s))


# Unit Tests
class TestValidNumber(unittest.TestCase):

    def test_examples(self):
        self.assertEqual(is_valid_number("1"), True, 'Example 1')
        self.assertEqual(is_valid_number("a"), False, 'Example 2')
        self.assertEqual(is_valid_number("."), False, 'Example 3')
        self.assertEqual(is_valid_number("1.2e4.2"), False, 'Example 4')
        self.assertEqual(is_valid_number("-1."), True, 'Example 5')
        self.assertEqual(is_valid_number("+1E-8"), True, 'Example 6')
        self.assertEqual(is_valid_number(".44"), True, 'Example 7')

    def test_additional(self):
        self.assertEqual(is_valid_number("6e6.5"), False,
                         'Exponent with decimal')
        self.assertEqual(is_valid_number(""), False, 'Empty string')
        self.assertEqual(is_valid_number("123"), True, 'Integer number')
        self.assertEqual(is_valid_number("-."), False,
                         'Negative dot without digits')
        self.assertEqual(is_valid_number("1e"), False, 'Incomplete exponent')


if __name__ == "__main__":
    unittest.main()
