#!/usr/bin/env python3
"""Complex Number - Perl Weekly Challenge 395 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import re
import sys
import unittest


def _parse_complex(s: str) -> tuple[int, int]:
    """Parse complex string in format a+bi or a+(-b)i."""
    match = re.match(r"^\s*([+-]?\d+)\s*\+\s*(?:\(([-+]?\d+)\)|([-+]?\d+))\s*i\s*$", s)
    if not match:
        raise ValueError(f"Invalid complex number format: {s}")
    real_str = match.group(1)
    imag_str = match.group(2) if match.group(2) is not None else match.group(3)
    return int(real_str), int(imag_str)


def _format_complex(real: int, imag: int) -> str:
    """Format complex number to match specification."""
    if imag < 0:
        return f"{real}+({imag})i"
    return f"{real}+{imag}i"


def multiply_complex(num1: str, num2: str) -> str:
    """Multiply two complex numbers and return formatted product."""
    a, b = _parse_complex(num1)
    c, d = _parse_complex(num2)

    real = a * c - b * d
    imag = a * d + b * c

    return _format_complex(real, imag)


class TestComplexMultiplication(unittest.TestCase):
    """Unit tests for multiply_complex."""

    def test_example1(self) -> None:
        """Test example 1."""
        self.assertEqual(multiply_complex("1+1i", "1+1i"), "0+2i")

    def test_example2(self) -> None:
        """Test example 2."""
        self.assertEqual(multiply_complex("1+(-1)i", "1+(-1)i"), "0+(-2)i")

    def test_example3(self) -> None:
        """Test example 3."""
        self.assertEqual(multiply_complex("0+3i", "0+4i"), "-12+0i")

    def test_example4(self) -> None:
        """Test example 4."""
        self.assertEqual(multiply_complex("3+4i", "3+(-4)i"), "25+0i")

    def test_example5(self) -> None:
        """Test example 5."""
        self.assertEqual(multiply_complex("50+(-20)i", "-10+30i"), "100+1700i")


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    if argv and len(argv) == 3:
        print(f"Output: {multiply_complex(argv[1], argv[2])}")
        return
    unittest.main(argv=[sys.argv[0]])


if __name__ == "__main__":
    main(sys.argv)
