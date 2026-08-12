#!/usr/bin/env python3
"""
Perl Weekly Challenge 386 - Task 2: Rational Numbers
Compare two rational numbers given as repeating decimal string representations.
"""

from fractions import Fraction
import re
import unittest


def parse_rational(rat_str: str) -> Fraction:
    """Parse a string like '0.1(23)' or '13.' or '0.(12)' into a Fraction."""
    match = re.match(r"^(\d+)(?:\.(\d*)(?:\((\d+)\))?)?$", rat_str)
    if not match:
        raise ValueError(f"Invalid rational format: {rat_str}")

    int_part, non_rep, rep = match.groups()
    int_val = int(int_part)
    non_rep = non_rep or ""
    rep = rep or ""

    frac = Fraction(0, 1)
    if rep:
        k = len(rep)
        m = len(non_rep)
        rep_val = int(rep)
        non_rep_val = int(non_rep) if non_rep else 0
        nine_val = int("9" * k)
        ten_m = 10**m

        num = non_rep_val * nine_val + rep_val
        den = nine_val * ten_m
        frac = Fraction(num, den)
    elif non_rep:
        m = len(non_rep)
        frac = Fraction(int(non_rep), 10**m)

    return int_val + frac


def compare_rationals(rat1: str, rat2: str) -> int:
    """Return 1 if rat1 == rat2 mathematically, else 0."""
    return 1 if parse_rational(rat1) == parse_rational(rat2) else 0


class TestRationalNumbers(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(compare_rationals("0.(12)", "0.(121)"), 0)
        self.assertEqual(compare_rationals("0.1(23)", "0.12(32)"), 1)
        self.assertEqual(compare_rationals("0.1(234)", "0.12(342)"), 1)
        self.assertEqual(compare_rationals("12.99(99)", "13."), 1)
        self.assertEqual(compare_rationals("0.(123)", "0.1(231)"), 1)


if __name__ == "__main__":
    unittest.main()
