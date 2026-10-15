#!/usr/bin/env python3
"""Poker Hand Rankings - Perl Weekly Challenge 291 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import math
import sys
import unittest


def nCr(n: int, r: int) -> int:
    """Calculate combination n choose r."""
    return math.comb(n, r)


def calculate_poker_hands() -> tuple[int, dict[str, int]]:
    """Calculate the total number of 5-card hands and frequency of each poker rank."""
    total_hands = nCr(52, 5)
    counts: dict[str, int] = {}

    # 1. Royal Flush
    counts["Royal Flush"] = 4

    # 2. Straight Flush (excluding Royal Flush)
    counts["Straight Flush"] = 9 * 4

    # 3. Four of a Kind
    counts["Four of a Kind"] = 13 * nCr(48, 1)

    # 4. Full House
    counts["Full House"] = 13 * nCr(4, 3) * 12 * nCr(4, 2)

    # 5. Flush (excluding Straight/Royal Flushes)
    total_flushes = 4 * nCr(13, 5)
    counts["Flush"] = total_flushes - counts["Royal Flush"] - counts["Straight Flush"]

    # 6. Straight (excluding Straight/Royal Flushes)
    total_straights = 10 * (4**5)
    counts["Straight"] = (
        total_straights - counts["Royal Flush"] - counts["Straight Flush"]
    )

    # 7. Three of a Kind
    counts["Three of a Kind"] = 13 * nCr(4, 3) * nCr(12, 2) * (4**2)

    # 8. Two Pair
    counts["Two Pair"] = nCr(13, 2) * (nCr(4, 2) ** 2) * 11 * 4

    # 9. One Pair
    counts["One Pair"] = 13 * nCr(4, 2) * nCr(12, 3) * (4**3)

    # 10. High Card
    sum_other = sum(counts.values())
    counts["High Card"] = total_hands - sum_other

    return total_hands, counts


class TestPokerHandRankings(unittest.TestCase):
    """Unit tests for calculate_poker_hands."""

    def test_total_and_counts(self) -> None:
        """Verify total hands, each hand count, and their sum."""
        total, counts = calculate_poker_hands()

        expected = {
            "Royal Flush": 4,
            "Straight Flush": 36,
            "Four of a Kind": 624,
            "Full House": 3744,
            "Flush": 5108,
            "Straight": 10200,
            "Three of a Kind": 54912,
            "Two Pair": 123552,
            "One Pair": 1098240,
            "High Card": 1302540,
        }

        self.assertEqual(total, 2598960)
        for rank, exp_val in expected.items():
            self.assertEqual(counts[rank], exp_val, f"{rank} count mismatch")

        self.assertEqual(sum(counts.values()), total)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    _ = argv
    total, counts = calculate_poker_hands()
    print(f"Total number of 5-card hands: {total}\n")
    print("Number of hands for each rank:")
    for rank in [
        "Royal Flush",
        "Straight Flush",
        "Four of a Kind",
        "Full House",
        "Flush",
        "Straight",
        "Three of a Kind",
        "Two Pair",
        "One Pair",
        "High Card",
    ]:
        print(f"{rank:16}: {counts[rank]}")
    print(f"\nSum of all hand counts: {sum(counts.values())}")
    print(f"Verification: {'Passed' if sum(counts.values()) == total else 'Failed'}")


if __name__ == "__main__":
    if len(sys.argv) > 1 and sys.argv[1] == "--test":
        unittest.main(argv=[sys.argv[0]])
    else:
        main(sys.argv)
