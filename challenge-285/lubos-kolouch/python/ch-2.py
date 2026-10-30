#!/usr/bin/env python3
"""Making Change - The Weekly Challenge 285 Task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def making_change(amount: int) -> int:
    """Compute the number of ways to make change for the given amount in cents.

    Coins available:
    - Penny (P): 1 cent
    - Nickel (N): 5 cents
    - Dime (D): 10 cents
    - Quarter (Q): 25 cents
    - Half-dollar (HD): 50 cents

    Order of coin selection does not matter.

    Args:
        amount: The amount in cents (non-negative integer).

    Returns:
        The number of distinct ways to make change.

    Raises:
        ValueError: If amount is negative.
    """
    if amount < 0:
        raise ValueError("Amount must be non-negative")

    coins: tuple[int, ...] = (1, 5, 10, 25, 50)
    dp: list[int] = [0] * (amount + 1)
    dp[0] = 1

    for coin in coins:
        for i in range(coin, amount + 1):
            dp[i] += dp[i - coin]

    return dp[amount]


class TestMakingChange(unittest.TestCase):
    """Unit tests for making_change."""

    def test_example1(self) -> None:
        """Test Example 1: amount = 9 -> 2."""
        self.assertEqual(making_change(9), 2)

    def test_example2(self) -> None:
        """Test Example 2: amount = 15 -> 6."""
        self.assertEqual(making_change(15), 6)

    def test_example3(self) -> None:
        """Test Example 3: amount = 100 -> 292."""
        self.assertEqual(making_change(100), 292)

    def test_zero_amount(self) -> None:
        """Test zero amount: amount = 0 -> 1."""
        self.assertEqual(making_change(0), 1)

    def test_negative_amount(self) -> None:
        """Test negative amount raises ValueError."""
        with self.assertRaises(ValueError):
            making_change(-1)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    if argv and len(argv) > 1:
        amount = int(argv[1])
        print(f"Output: {making_change(amount)}")
        return
    unittest.main(argv=[sys.argv[0]])


if __name__ == "__main__":
    main(sys.argv)
