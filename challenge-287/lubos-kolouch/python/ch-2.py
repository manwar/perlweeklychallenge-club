#!/usr/bin/env python3
"""Valid Number - The Weekly Challenge 287 Task 2."""

from __future__ import annotations

from collections.abc import Sequence
import re
import sys
import unittest


def is_valid_number(s: str) -> bool:
    """Determine if the given string is a valid number.

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
        s: The input string.

    Returns:
        True if the string is a valid number, False otherwise.
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


class TestValidNumber(unittest.TestCase):
    """Unit tests for is_valid_number."""

    def test_example1(self) -> None:
        """Test Example 1: '1' is a valid number."""
        self.assertTrue(is_valid_number("1"))

    def test_example2(self) -> None:
        """Test Example 2: 'a' is not a valid number."""
        self.assertFalse(is_valid_number("a"))

    def test_example3(self) -> None:
        """Test Example 3: '.' is not a valid number."""
        self.assertFalse(is_valid_number("."))

    def test_example4(self) -> None:
        """Test Example 4: '1.2e4.2' is not a valid number (non-integer exponent)."""
        self.assertFalse(is_valid_number("1.2e4.2"))

    def test_example5(self) -> None:
        """Test Example 5: '-1.' is a valid decimal number."""
        self.assertTrue(is_valid_number("-1."))

    def test_example6(self) -> None:
        """Test Example 6: '+1E-8' is a valid number with exponent."""
        self.assertTrue(is_valid_number("+1E-8"))

    def test_example7(self) -> None:
        """Test Example 7: '.44' is a valid decimal number."""
        self.assertTrue(is_valid_number(".44"))

    def test_exponent_with_decimal(self) -> None:
        """Test exponent containing a decimal point."""
        self.assertFalse(is_valid_number("6e6.5"))

    def test_empty_string(self) -> None:
        """Test empty string."""
        self.assertFalse(is_valid_number(""))

    def test_integer_number(self) -> None:
        """Test standard integer string."""
        self.assertTrue(is_valid_number("123"))

    def test_negative_dot_only(self) -> None:
        """Test negative dot without digits."""
        self.assertFalse(is_valid_number("-."))

    def test_incomplete_exponent(self) -> None:
        """Test incomplete exponent symbol."""
        self.assertFalse(is_valid_number("1e"))


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    if argv and len(argv) > 1:
        print(f"Output: {is_valid_number(argv[1])}")
        return
    unittest.main(argv=[sys.argv[0]])


if __name__ == "__main__":
    main(sys.argv)
