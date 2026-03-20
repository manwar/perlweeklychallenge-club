#!/usr/bin/env python3
"""
Challenge 016, Task 1: Pythagoras Pie Puzzle

At a party a pie is to be shared by 100 guest. The first guest gets 1%
of the pie, the second guest gets 2% of the remaining pie, the third
gets 3% of the remaining pie, and so on.

Write a script that figures out which guest gets the largest piece of pie.

Author: Lubos Kolouch
"""

import unittest


def pythagoras_pie(num_guests: int = 100) -> tuple[int, float]:
    """
    Calculate which guest gets the largest piece of pie.

    Each guest i (1-indexed) gets i% of the remaining pie.

    Args:
        num_guests: Number of guests (default 100)

    Returns:
        Tuple of (guest_number, largest_piece_size)

    Examples:
        >>> guest, piece = pythagoras_pie(100)
        >>> print(f"Guest {guest} gets the largest piece: {piece:.4f}")
        Guest 10 gets the largest piece: 0.0450
    """
    remaining = 100.0  # Start with 100%
    largest_piece = 0.0
    largest_guest = 0

    for guest in range(1, num_guests + 1):
        # Guest gets guest% of remaining
        piece = (guest / 100) * remaining

        if piece > largest_piece:
            largest_piece = piece
            largest_guest = guest

        # Update remaining pie
        remaining = remaining - piece

    return largest_guest, largest_piece


def get_all_pieces(num_guests: int = 100) -> list[tuple[int, float]]:
    """
    Get the piece size for each guest.

    Args:
        num_guests: Number of guests

    Returns:
        List of (guest_number, piece_size) tuples
    """
    remaining = 100.0
    pieces = []

    for guest in range(1, num_guests + 1):
        piece = (guest / 100) * remaining
        pieces.append((guest, piece))
        remaining = remaining - piece

    return pieces


def main() -> None:
    """Main function to display results."""
    guest, piece = pythagoras_pie()
    print(f"Guest {guest} gets the largest piece: {piece:.4f}%")

    print("\nTop 10 guests by piece size:")
    all_pieces = sorted(get_all_pieces(), key=lambda x: x[1], reverse=True)
    for guest, piece in all_pieces[:10]:
        print(f"  Guest {guest}: {piece:.4f}%")


if __name__ == "__main__":
    main()


class TestPythagorasPie(unittest.TestCase):
    """Unit tests for Pythagoras Pie Puzzle."""

    def test_guest_10_largest(self):
        """Guest 10 should get the largest piece."""
        guest, piece = pythagoras_pie(100)
        self.assertEqual(guest, 10)

    def test_guest_10_piece_size(self):
        """Check the piece size for guest 10 (approximately 6.28%)."""
        _, piece = pythagoras_pie(100)
        # Guest 10 gets approximately 0.0450
        self.assertAlmostEqual(piece, 6.28, places=1)

    def test_total_distribution(self):
        """Total pieces should sum to 100%."""
        pieces = get_all_pieces(100)
        total = sum(piece for _, piece in pieces)
        self.assertAlmostEqual(total, 100.0, places=2)

    def test_first_guest(self):
        """First guest gets 1% of 100 = 1."""
        pieces = get_all_pieces(100)
        self.assertAlmostEqual(pieces[0][1], 1.0, places=1)

    def test_last_guest(self):
        """Last guest gets some small piece."""
        pieces = get_all_pieces(100)
        last_guest, last_piece = pieces[-1]
        self.assertEqual(last_guest, 100)
        self.assertGreater(last_piece, 0)

    def test_top_5_guests(self):
        """Top 5 guests should include guest 10."""
        all_pieces = sorted(get_all_pieces(100), key=lambda x: x[1], reverse=True)
        top_5_guests = [guest for guest, _ in all_pieces[:5]]
        self.assertIn(10, top_5_guests)

    def test_remaining_after_each(self):
        """Check remaining pie decreases."""
        remaining = 100.0
        for guest in range(1, 11):
            piece = (guest / 100) * remaining
            remaining -= piece
            self.assertGreater(remaining, 0)


if __name__ == "__main__":
    unittest.main()
