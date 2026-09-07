#!/usr/bin/env python3
"""Perl Weekly Challenge 389 - Task 1: Reorder Notes.

Reconstruct a melody by using each permutation value as the destination
position of the corresponding note without using explicit loops.
"""

from __future__ import annotations

import unittest


def reorder_notes(melody: list) -> str:
    """Reorder notes according to 1-based destination permutation.

    :param melody: [composer, notes, permutation]
    :return: Formatted string 'COMPOSER => reordered notes'
    """
    composer, notes, perm = melody
    reordered = [note for _, note in sorted(zip(perm, notes))]
    return f"{composer.upper()} => {' '.join(reordered)}"


class TestReorderNotes(unittest.TestCase):
    """Test cases for reorder_notes."""

    def test_example_1(self) -> None:
        self.assertEqual(
            reorder_notes(
                ["Bach", ["C", "D", "E", "F#", "G", "A", "B"], [7, 1, 6, 2, 5, 3, 4]]
            ),
            "BACH => D F# A B G E C",
        )

    def test_example_2(self) -> None:
        self.assertEqual(
            reorder_notes(["Beethoven", ["C", "D", "F#", "G", "Ab"], [1, 3, 5, 2, 4]]),
            "BEETHOVEN => C G D Ab F#",
        )

    def test_example_3(self) -> None:
        self.assertEqual(
            reorder_notes(
                [
                    "Brahms",
                    ["C", "Db", "Eb", "F", "G", "Ab", "Bb", "C", "D"],
                    [9, 3, 7, 1, 8, 5, 2, 6, 4],
                ]
            ),
            "BRAHMS => F Bb Db D Ab C Eb G C",
        )

    def test_example_4(self) -> None:
        self.assertEqual(
            reorder_notes(
                [
                    "Bruckner",
                    ["G", "F#", "Bb", "C", "D", "Eb", "F"],
                    [4, 7, 2, 6, 1, 5, 3],
                ]
            ),
            "BRUCKNER => D Bb F G Eb C F#",
        )

    def test_example_5(self) -> None:
        self.assertEqual(
            reorder_notes(["Berg", ["C#"], [1]]),
            "BERG => C#",
        )


if __name__ == "__main__":
    unittest.main()
