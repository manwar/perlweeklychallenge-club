#!/usr/bin/env python
# -*- coding: utf-8 -*-

import unittest


def decimal_to_octal(decimal: int) -> str:
    """Converts a decimal number to an octal string.

    Args:
        decimal: The decimal number to convert.

    Returns:
        The octal string representation of the decimal number.
    """
    return oct(decimal)[2:]


class TestDecimalToOctal(unittest.TestCase):
    def test_zero(self) -> None:
        self.assertEqual(decimal_to_octal(0), "0")

    def test_single_digit(self) -> None:
        self.assertEqual(decimal_to_octal(5), "5")

    def test_multiple_digits(self) -> None:
        self.assertEqual(decimal_to_octal(50), "62")


if __name__ == "__main__":
    unittest.main()

for i in range(0, 51):
    octal = decimal_to_octal(i)
    print(f"Decimal {i} = Octal {octal}")
