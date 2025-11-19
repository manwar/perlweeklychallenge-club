#!/usr/bin/env python3
"""Format Phone Number - Perl Weekly Challenge 347 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def format_phone_number(text: str) -> str:
    """Group phone digits from the left using 3-digit blocks with special tail handling."""
    if any(ch for ch in text if ch not in "0123456789 -"):
        raise ValueError("Invalid characters in phone number")

    digits = "".join(ch for ch in text if ch.isdigit())
    if len(digits) < 2:
        raise ValueError("Phone number requires at least two digits")

    blocks: list[str] = []
    idx = 0
    while len(digits) - idx > 4:
        blocks.append(digits[idx:idx + 3])
        idx += 3

    tail = digits[idx:]
    if len(tail) == 4:
        blocks.extend([tail[:2], tail[2:]])
    elif tail:
        blocks.append(tail)

    return "-".join(blocks)


class FormatPhoneNumberExamples(unittest.TestCase):
    """Specification-provided examples."""

    def test_example_1(self) -> None:
        self.assertEqual(format_phone_number("1-23-45-6"), "123-456")

    def test_example_2(self) -> None:
        self.assertEqual(format_phone_number("1234"), "12-34")

    def test_example_3(self) -> None:
        self.assertEqual(format_phone_number("12 345-6789"), "123-456-789")

    def test_example_4(self) -> None:
        self.assertEqual(format_phone_number("123 4567"), "123-45-67")

    def test_example_5(self) -> None:
        self.assertEqual(format_phone_number("123 456-78"), "123-456-78")


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    if len(args) != 1:
        raise SystemExit('Usage: python3 ch-2.py "12 345-6789"')

    phone = args[0]
    print(f'Input:  $phone = "{phone}"')
    formatted = format_phone_number(phone)
    print(f'Output: "{formatted}"')


if __name__ == "__main__":
    main()
