#!/usr/bin/env python3
"""6 out of 49 - Perl Weekly Challenge 246, Task 1."""

from __future__ import annotations

import random
import unittest


def pick_lotto_numbers(count: int = 6, max_val: int = 49) -> list[int]:
    """Return count unique random integers from the range 1..max_val."""
    return random.sample(range(1, max_val + 1), count)  # nosec B311


class TestLottoNumbers(unittest.TestCase):
    """Unit tests for the pick_lotto_numbers function."""

    def test_lotto_numbers(self) -> None:
        """Verify count, uniqueness, and bounds of picked lotto numbers."""
        result = pick_lotto_numbers()
        self.assertEqual(len(result), 6)
        self.assertEqual(len(set(result)), 6)
        for num in result:
            self.assertTrue(1 <= num <= 49)


if __name__ == "__main__":
    unittest.main()
