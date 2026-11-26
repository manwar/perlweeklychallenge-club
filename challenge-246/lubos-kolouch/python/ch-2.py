#!/usr/bin/env python3
"""Linear Recurrence of Second Order - Perl Weekly Challenge 246, Task 2."""

from __future__ import annotations

import unittest


def is_linear_recurrence(a: list[int]) -> bool:
    """Return True if a forms a second-order linear recurrence with integer factors."""
    if len(a) < 5:
        return False

    det = a[0] * a[2] - a[1] ** 2
    if det != 0:
        p_num = a[2] * a[2] - a[1] * a[3]
        q_num = a[0] * a[3] - a[1] * a[2]
        if p_num % det != 0 or q_num % det != 0:
            return False
        p = p_num // det
        q = q_num // det
    elif a[0] == 0:
        p, q = 0, 0
    else:
        if a[1] % a[0] != 0:
            return False
        p, q = 0, a[1] // a[0]

    return all(a[i] == p * a[i - 2] + q * a[i - 1] for i in range(2, len(a)))


class TestLinearRecurrence(unittest.TestCase):
    """Unit tests for the is_linear_recurrence function."""

    def test_examples(self) -> None:
        """Verify all challenge examples and edge cases."""
        cases: list[tuple[list[int], bool]] = [
            ([1, 1, 2, 3, 5], True),
            ([4, 2, 4, 5, 7], False),
            ([4, 1, 2, -3, 8], True),
            ([1, 2, 4, 8, 16], True),
            ([0, 0, 0, 0, 0], True),
        ]
        for seq, expected in cases:
            with self.subTest(seq=seq):
                self.assertEqual(is_linear_recurrence(seq), expected)


if __name__ == "__main__":
    unittest.main()
