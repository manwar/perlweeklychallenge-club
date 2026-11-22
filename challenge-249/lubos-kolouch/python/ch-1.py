#!/usr/bin/env python3
"""Equal Pairs - Perl Weekly Challenge 249, Task 1."""

from __future__ import annotations

from collections import Counter
import unittest


def equal_pairs(ints: list[int]) -> list[list[int]]:
    """Divide integers into equal pairs, or return [] if impossible."""
    freq = Counter(ints)
    seen: set[int] = set()
    ordered_elements: list[int] = []

    for num in ints:
        if num not in seen:
            seen.add(num)
            ordered_elements.append(num)

    if any(count % 2 for count in freq.values()):
        return []

    pairs: list[list[int]] = []
    for num in ordered_elements:
        pairs.extend([[num, num] for _ in range(freq[num] // 2)])

    return pairs


class TestEqualPairs(unittest.TestCase):
    """Unit tests for the equal_pairs function."""

    def test_examples(self) -> None:
        """Verify all challenge examples and edge cases."""
        cases: list[tuple[list[int], list[list[int]]]] = [
            ([3, 2, 3, 2, 2, 2], [[3, 3], [2, 2], [2, 2]]),
            ([1, 2, 3, 4], []),
            ([], []),
        ]
        for ints, expected in cases:
            with self.subTest(ints=ints):
                self.assertEqual(equal_pairs(ints), expected)


if __name__ == "__main__":
    unittest.main()
