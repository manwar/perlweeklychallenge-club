#!/usr/bin/env python3
"""Perl Weekly Challenge 393 - Task 1: Pythagoras Multiplied.

Find the number of all positive integer triplets (a, b, c) so that
a^2 + b^2 = c^2 and a, b, and c are integers <= n.
"""

import math
import unittest


def count_pythagorean_triplets(n: int) -> int:
    """Count positive integer triplets (a, b, c) with a^2 + b^2 = c^2 and a, b, c <= n.

    Args:
        n: The upper bound for a, b, c.

    Returns:
        The total count of valid ordered triplets.
    """
    if n < 5:
        return 0

    count = 0
    for a in range(1, n + 1):
        a2 = a * a
        for b in range(1, n + 1):
            c2 = a2 + b * b
            c = math.isqrt(c2)
            if c <= n and c * c == c2:
                count += 1
    return count


class TestPythagorasMultiplied(unittest.TestCase):
    """Test suite for count_pythagorean_triplets."""

    def test_examples(self) -> None:
        """Test with challenge examples."""
        self.assertEqual(count_pythagorean_triplets(20), 12)
        self.assertEqual(count_pythagorean_triplets(7), 2)
        self.assertEqual(count_pythagorean_triplets(1), 0)
        self.assertEqual(count_pythagorean_triplets(15), 8)
        self.assertEqual(count_pythagorean_triplets(30), 22)


if __name__ == "__main__":
    unittest.main()
