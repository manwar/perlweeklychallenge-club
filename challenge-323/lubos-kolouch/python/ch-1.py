#!/usr/bin/env python3
"""
Task: Increment Decrement (Weekly Challenge 323)

Apply ++/-- operations starting from 0 and return the final value.
"""
from __future__ import annotations

import unittest
from typing import List


def final_value(ops: List[str]) -> int:
    value = 0
    for op in ops:
        if "++" in op:
            value += 1
        elif "--" in op:
            value -= 1
    return value


class FinalValueTests(unittest.TestCase):
    def test_examples(self) -> None:
        self.assertEqual(final_value(["--x", "x++", "x++"]), 1)
        self.assertEqual(final_value(["x++", "++x", "x++"]), 3)
        self.assertEqual(final_value(["x++", "++x", "--x", "x--"]), 0)


if __name__ == "__main__":
    unittest.main()
