#!/usr/bin/env python3

import re
from fractions import Fraction
import unittest

def fraction_calc(expr: str) -> str:
    total = Fraction(0, 1)
    for token in re.findall(r"[+-]?\d+/\d+", expr):
        total += Fraction(token)
    return f"{total.numerator}/{total.denominator}"

class TestFractionCalc(unittest.TestCase):
    def test_examples(self):
        examples = [
            ("1/2+3/2", "2/1"),
            ("-5/2-3/2", "-4/1"),
            ("5/3-5/3", "0/1"),
            ("10/10-1/10+2/5", "13/10"),
            ("1/6+1/6+1/6", "1/2"),
        ]
        for inp, out in examples:
            with self.subTest(inp=inp):
                self.assertEqual(fraction_calc(inp), out)

if __name__ == "__main__":
    unittest.main()
