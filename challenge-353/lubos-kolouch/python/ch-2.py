#!/usr/bin/env python3
"""Validate Coupon - Perl Weekly Challenge 353 task 2."""

from __future__ import annotations

from collections.abc import Sequence
from typing import Final
import sys
import unittest

ALLOWED_NAMES: Final[set[str]] = {"electronics", "grocery", "pharmacy", "restaurant"}


def _status_is_true(value: str) -> bool:
    return value.lower() in {"true", "1"}


def validate_coupons(
    codes: Sequence[str], names: Sequence[str], status: Sequence[str]
) -> list[bool]:
    """
    Validate coupon entries.

    A coupon is valid iff:
    - codes[i] is non-empty and contains only alphanumeric/underscore characters
    - names[i] is one of the allowed categories
    - status[i] is true
    """
    if not (len(codes) == len(names) == len(status)):
        raise ValueError("Input arrays must have the same length")

    output: list[bool] = []
    for code, name, st in zip(codes, names, status, strict=True):
        code_ok = bool(code) and all(ch.isalnum() or ch == "_" for ch in code)
        name_ok = name in ALLOWED_NAMES
        status_ok = _status_is_true(st)
        output.append(code_ok and name_ok and status_ok)
    return output


class ValidateCouponExamples(unittest.TestCase):
    """Example-based tests from the challenge specification."""

    def test_example_1(self) -> None:
        self.assertEqual(
            validate_coupons(
                ("A123", "B_456", "C789", "D@1", "E123"),
                ("electronics", "restaurant", "electronics", "pharmacy", "grocery"),
                ("true", "false", "true", "true", "true"),
            ),
            [True, False, True, False, True],
        )

    def test_example_2(self) -> None:
        self.assertEqual(
            validate_coupons(
                ("Z_9", "AB_12", "G01", "X99", "test"),
                ("pharmacy", "electronics", "grocery", "electronics", "unknown"),
                ("true", "true", "false", "true", "true"),
            ),
            [True, True, False, True, False],
        )

    def test_example_3(self) -> None:
        self.assertEqual(
            validate_coupons(
                ("_123", "123", "", "Coupon_A", "Alpha"),
                ("restaurant", "electronics", "electronics", "pharmacy", "grocery"),
                ("true", "true", "false", "true", "true"),
            ),
            [True, True, False, True, True],
        )

    def test_example_4(self) -> None:
        self.assertEqual(
            validate_coupons(
                ("ITEM_1", "ITEM_2", "ITEM_3", "ITEM_4"),
                ("electronics", "electronics", "grocery", "grocery"),
                ("true", "true", "true", "true"),
            ),
            [True, True, True, True],
        )

    def test_example_5(self) -> None:
        self.assertEqual(
            validate_coupons(
                ("CAFE_X", "ELEC_100", "FOOD_1", "DRUG_A", "ELEC_99"),
                ("restaurant", "electronics", "grocery", "pharmacy", "electronics"),
                ("true", "true", "true", "true", "false"),
            ),
            [True, True, True, True, False],
        )


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    codes: list[str] = []
    names: list[str] = []
    status: list[str] = []
    for triple in args:
        code, name, st = (triple.split(",", 2) + ["", "", ""])[:3]
        codes.append(code)
        names.append(name)
        status.append(st)

    output = validate_coupons(codes, names, status)
    rendered = ", ".join("true" if value else "false" for value in output)
    print(f"Output: ({rendered})")


if __name__ == "__main__":
    main()
