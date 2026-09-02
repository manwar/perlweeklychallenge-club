#!/usr/bin/env python3
"""Perl Weekly Challenge 388 - Task 1: Dyck Word.

Generate all valid Dyck words of length 2*$n consisting of 'U' and 'D'
sorted in lexicographical order.
"""

from __future__ import annotations

import unittest


def dyck_words(n: int) -> list[str]:
    """Return all valid Dyck words of length 2*n in lexicographical order.

    :param n: Order of Dyck word.
    :return: List of valid Dyck words.
    """
    if n == 0:
        return [""]

    result: list[str] = []

    def generate(current: str, u_count: int, d_count: int) -> None:
        if u_count == n and d_count == n:
            result.append(current)
            return

        # 'D' comes before 'U' in alphabetical order
        if d_count < u_count:
            generate(current + "D", u_count, d_count + 1)
        if u_count < n:
            generate(current + "U", u_count + 1, d_count)

    generate("", 0, 0)
    return result


class TestDyckWords(unittest.TestCase):
    """Test cases for dyck_words."""

    def test_example_1(self) -> None:
        self.assertEqual(dyck_words(1), ["UD"])

    def test_example_2(self) -> None:
        self.assertEqual(dyck_words(2), ["UDUD", "UUDD"])

    def test_example_3(self) -> None:
        self.assertEqual(
            dyck_words(3),
            ["UDUDUD", "UDUUDD", "UUDDUD", "UUDUDD", "UUUDDD"],
        )

    def test_example_4(self) -> None:
        self.assertEqual(dyck_words(0), [""])

    def test_example_5(self) -> None:
        self.assertEqual(
            dyck_words(4),
            [
                "UDUDUDUD",
                "UDUDUUDD",
                "UDUUDDUD",
                "UDUUDUDD",
                "UDUUUDDD",
                "UUDDUDUD",
                "UUDDUUDD",
                "UUDUDDUD",
                "UUDUDUDD",
                "UUDUUDDD",
                "UUUDDDUD",
                "UUUDDUDD",
                "UUUDUDDD",
                "UUUUDDDD",
            ],
        )


if __name__ == "__main__":
    unittest.main()
