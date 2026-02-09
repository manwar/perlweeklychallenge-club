#!/usr/bin/env python3
"""
Perl Weekly Challenge 103 - Task 1: Chinese Zodiac

Given a year, determine the Chinese Zodiac (element + animal).

The animal cycle:
  Rat, Ox, Tiger, Rabbit, Dragon, Snake, Horse, Goat, Monkey,
  Rooster, Dog, Pig

The element cycle (each repeated twice):
  Wood, Fire, Earth, Metal, Water
"""

from __future__ import annotations

from typing import Sequence


ANIMALS: list[str] = [
    "Rat",
    "Ox",
    "Tiger",
    "Rabbit",
    "Dragon",
    "Snake",
    "Horse",
    "Goat",
    "Monkey",
    "Rooster",
    "Dog",
    "Pig",
]
ELEMENTS: list[str] = ["Wood", "Fire", "Earth", "Metal", "Water"]


def chinese_zodiac(year: int) -> str:
    """
    Return the Chinese Zodiac for `year` as "<Element> <Animal>".

    Uses 1924 (Wood Rat) as the cycle base.
    """
    offset = year - 1924
    animal = ANIMALS[offset % 12]
    element = ELEMENTS[((offset % 10) // 2) % 5]
    return f"{element} {animal}"


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    if len(argv) != 1:
        raise SystemExit(f"Usage: {__file__} <year>")
    print(chinese_zodiac(int(argv[0])))


def _run_tests() -> None:
    import unittest

    class TestChallenge103Task1(unittest.TestCase):
        def test_example_1(self) -> None:
            self.assertEqual(chinese_zodiac(2017), "Fire Rooster")

        def test_example_2(self) -> None:
            self.assertEqual(chinese_zodiac(1938), "Earth Tiger")

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge103Task1)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

