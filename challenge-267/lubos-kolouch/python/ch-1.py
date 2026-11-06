#!/usr/bin/env python3
"""Product Sign - The Weekly Challenge 267 Task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def product_sign(ints: list[int]) -> int:
    """Compute the sign of the product of a list of integers.

    Args:
        ints: A list of integers.

    Returns:
        1 if the product is positive, -1 if negative, or 0 if zero.
    """
    negative_count = 0
    for value in ints:
        if value == 0:
            return 0
        if value < 0:
            negative_count += 1

    return -1 if negative_count % 2 != 0 else 1


class TestProductSign(unittest.TestCase):
    """Unit tests for product_sign."""

    def test_example1(self) -> None:
        """Test Example 1: [-1, -2, -3, -4, 3, 2, 1] -> 1."""
        self.assertEqual(product_sign([-1, -2, -3, -4, 3, 2, 1]), 1)

    def test_example2(self) -> None:
        """Test Example 2: [1, 2, 0, -2, -1] -> 0."""
        self.assertEqual(product_sign([1, 2, 0, -2, -1]), 0)

    def test_example3(self) -> None:
        """Test Example 3: [-1, -1, 1, -1, 2] -> -1."""
        self.assertEqual(product_sign([-1, -1, 1, -1, 2]), -1)

    def test_additional(self) -> None:
        """Test additional edge cases."""
        self.assertEqual(product_sign([]), 1)
        self.assertEqual(product_sign([0]), 0)
        self.assertEqual(product_sign([-5]), -1)
        self.assertEqual(product_sign([5]), 1)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    if argv and len(argv) > 1:
        nums = [int(x) for x in argv[1:]]
        print(f"Output: {product_sign(nums)}")
        return
    unittest.main(argv=[sys.argv[0]])


if __name__ == "__main__":
    main(sys.argv)
