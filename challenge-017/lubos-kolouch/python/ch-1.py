#!/usr/bin/env python3
"""
Challenge 017, Task 1: Ackermann function

The Ackermann function is defined as:
    A(m, n) = n + 1                  if m = 0
    A(m, n) = A(m - 1, 1)            if m > 0 and n = 0
    A(m, n) = A(m - 1, A(m, n - 1))  if m > 0 and n > 0

Author: Lubos Kolouch
"""

import functools
import unittest


# Cache for memoization
@functools.cache
def ackermann(m: int, n: int) -> int:
    """
    Calculate the Ackermann function A(m, n).

    The Ackermann function grows extremely rapidly and is often used
    to benchmark recursion implementations.

    Args:
        m: Non-negative integer
        n: Non-negative integer

    Returns:
        The Ackermann function value

    Examples:
        >>> ackermann(0, 0)
        1
        >>> ackermann(1, 2)
        4
        >>> ackermann(2, 2)
        7
    """
    if m < 0 or n < 0:
        raise ValueError("m and n must be non-negative")

    if m == 0:
        return n + 1
    if n == 0:
        return ackermann(m - 1, 1)
    return ackermann(m - 1, ackermann(m, n - 1))


def ackermann_values(limit_m: int = 3, limit_n: int = 5) -> dict[tuple[int, int], int]:
    """
    Calculate Ackermann values up to given limits.

    Args:
        limit_m: Maximum value for m
        limit_n: Maximum value for n

    Returns:
        Dictionary of (m, n) -> A(m, n)
    """
    results = {}
    for m in range(limit_m + 1):
        for n in range(limit_n + 1):
            results[(m, n)] = ackermann(m, n)
    return results


def main() -> None:
    """Main function to display results."""
    print("Ackermann Function Values:")
    print("-" * 40)

    values = ackermann_values(3, 5)
    for (m, n), result in values.items():
        print(f"A({m}, {n}) = {result}")


if __name__ == "__main__":
    main()


class TestAckermann(unittest.TestCase):
    """Unit tests for Ackermann function."""

    def test_base_cases(self):
        """Test base cases."""
        self.assertEqual(ackermann(0, 0), 1)
        self.assertEqual(ackermann(0, 1), 2)
        self.assertEqual(ackermann(0, 5), 6)

    def test_m_1(self):
        """Test m=1 cases."""
        self.assertEqual(ackermann(1, 0), 2)
        self.assertEqual(ackermann(1, 1), 3)
        self.assertEqual(ackermann(1, 2), 4)
        self.assertEqual(ackermann(1, 3), 5)

    def test_m_2(self):
        """Test m=2 cases."""
        self.assertEqual(ackermann(2, 0), 3)
        self.assertEqual(ackermann(2, 1), 5)
        self.assertEqual(ackermann(2, 2), 7)
        self.assertEqual(ackermann(2, 3), 9)

    def test_m_3(self):
        """Test m=3 cases."""
        self.assertEqual(ackermann(3, 0), 5)
        # A(3, 1) = 13
        # A(3, 2) = 29
        self.assertEqual(ackermann(3, 1), 13)
        self.assertEqual(ackermann(3, 2), 29)

    def test_negative_m(self):
        """Test negative m raises error."""
        with self.assertRaises(ValueError):
            ackermann(-1, 0)

    def test_negative_n(self):
        """Test negative n raises error."""
        with self.assertRaises(ValueError):
            ackermann(0, -1)

    def test_cached_results(self):
        """Test that caching works correctly."""
        # Call same values multiple times
        result1 = ackermann(2, 2)
        result2 = ackermann(2, 2)
        self.assertEqual(result1, result2)
        self.assertEqual(result1, 7)


if __name__ == "__main__":
    unittest.main()
