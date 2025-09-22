#!/usr/bin/env python3
"""Solutions for The Weekly Challenge 340, Task 2 (Ascending Numbers).

The challenge provides a space-separated string containing words and positive
integers without leading zeros. The goal is to determine whether the numeric
subsequence appears in strictly increasing order. Only the official examples
are used for verification, as required.
"""

from __future__ import annotations

import unittest


def ascending_numbers(text: str) -> bool:
    """Return ``True`` if the numbers inside *text* increase strictly."""

    last_value: int | None = None
    for token in text.split(" "):
        if not token.isdigit():
            continue

        value = int(token)
        if last_value is not None and value <= last_value:
            return False
        last_value = value

    return True


class AscendingNumbersTests(unittest.TestCase):
    """Exercises the routine against the provided examples."""

    def test_example_1(self) -> None:
        self.assertTrue(
            ascending_numbers("The cat has 3 kittens 7 toys 10 beds"))

    def test_example_2(self) -> None:
        self.assertFalse(
            ascending_numbers("Alice bought 5 apples 2 oranges 9 bananas"))

    def test_example_3(self) -> None:
        self.assertTrue(
            ascending_numbers("I ran 1 mile 2 days 3 weeks 4 months"))

    def test_example_4(self) -> None:
        self.assertFalse(ascending_numbers("Bob has 10 cars 10 bikes"))

    def test_example_5(self) -> None:
        self.assertTrue(ascending_numbers("Zero is 0 one is 1 two is 2"))


if __name__ == "__main__":
    unittest.main()
