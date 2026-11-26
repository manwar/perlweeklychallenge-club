#!/usr/bin/env python3
"""Reconstruct Digits - Perl Weekly Challenge 401, Task 2."""

from __future__ import annotations

from collections import Counter
import unittest


def reconstruct_digits(text: str) -> str:
    """Reconstruct digits 0-9 in ascending order from scrambled English digit words."""
    freq = Counter(text)
    count = [0] * 10

    count[0] = freq["z"]
    count[2] = freq["w"]
    count[4] = freq["u"]
    count[6] = freq["x"]
    count[8] = freq["g"]

    count[1] = freq["o"] - count[0] - count[2] - count[4]
    count[3] = freq["h"] - count[8]
    count[5] = freq["f"] - count[4]
    count[7] = freq["s"] - count[6]
    count[9] = freq["i"] - count[5] - count[6] - count[8]

    return "".join(str(digit) * count[digit] for digit in range(10))


class TestReconstructDigits(unittest.TestCase):
    """Unit tests for the reconstruct_digits function."""

    def test_examples(self) -> None:
        """Verify all challenge examples."""
        cases: list[tuple[str, str]] = [
            ("zroezerotwotwotwo", "00222"),
            ("sveeeinght", "78"),
            ("onenineninefive", "1599"),
            ("zeroonetwothreeeightfivesixsevenninefour", "0123456789"),
            ("ninenineninenine", "9999"),
        ]
        for text, expected in cases:
            with self.subTest(text=text):
                self.assertEqual(reconstruct_digits(text), expected)


if __name__ == "__main__":
    unittest.main()
