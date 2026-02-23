#!/usr/bin/env python3
"""
Perl Weekly Challenge 362 - Task 2: Spellbound Sorting

Sort integers by the alphabetical order of their word forms.
Default language is English; French is supported for the official example.
"""

from __future__ import annotations

from typing import List, Sequence


_EN_UNITS = [
    "zero",
    "one",
    "two",
    "three",
    "four",
    "five",
    "six",
    "seven",
    "eight",
    "nine",
]

_EN_TEENS = {
    10: "ten",
    11: "eleven",
    12: "twelve",
    13: "thirteen",
    14: "fourteen",
    15: "fifteen",
    16: "sixteen",
    17: "seventeen",
    18: "eighteen",
    19: "nineteen",
}

_EN_TENS = {
    20: "twenty",
    30: "thirty",
    40: "forty",
    50: "fifty",
    60: "sixty",
    70: "seventy",
    80: "eighty",
    90: "ninety",
}

_FR_SMALL = {
    0: "zero",
    1: "un",
    2: "deux",
    3: "trois",
    4: "quatre",
    5: "cinq",
}


def number_to_words_en(n: int) -> str:
    """Convert integer to English words for sorting."""
    if n < 0:
        return f"minus {number_to_words_en(-n)}"
    if n < 10:
        return _EN_UNITS[n]
    if n < 20:
        return _EN_TEENS[n]
    if n < 100:
        tens = (n // 10) * 10
        unit = n % 10
        return _EN_TENS[tens] if unit == 0 else f"{_EN_TENS[tens]}-{_EN_UNITS[unit]}"
    if n < 1000:
        hundreds = n // 100
        rem = n % 100
        base = f"{_EN_UNITS[hundreds]} hundred"
        return base if rem == 0 else f"{base} and {number_to_words_en(rem)}"
    if n < 1_000_000:
        thousands = n // 1000
        rem = n % 1000
        base = f"{number_to_words_en(thousands)} thousand"
        return base if rem == 0 else f"{base} {number_to_words_en(rem)}"
    raise ValueError("number outside supported range")


def number_to_words_fr(n: int) -> str:
    """Minimal French support used by official example 3."""
    if n < 0:
        return f"moins {number_to_words_fr(-n)}"
    if n in _FR_SMALL:
        return _FR_SMALL[n]
    raise ValueError("French conversion currently supports only -5..5 in examples")


def spellbound_sort(numbers: Sequence[int], lang: str = "en") -> List[int]:
    """Sort numbers by alphabetical order of their word forms."""
    if lang == "en":
        words = {n: number_to_words_en(n) for n in numbers}
    elif lang == "fr":
        words = {n: number_to_words_fr(n) for n in numbers}
    else:
        raise ValueError("Unsupported language; use 'en' or 'fr'")

    return sorted(numbers, key=lambda n: words[n])


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    raise SystemExit("Run without arguments to execute the embedded tests.")


def _run_tests() -> None:
    import unittest

    class TestChallenge362Task2(unittest.TestCase):
        def test_example_1(self) -> None:
            self.assertEqual(spellbound_sort([6, 7, 8, 9, 10]), [8, 9, 7, 6, 10])

        def test_example_2(self) -> None:
            self.assertEqual(spellbound_sort([-3, 0, 1000, 99]), [-3, 99, 1000, 0])

        def test_example_3_french(self) -> None:
            self.assertEqual(spellbound_sort([1, 2, 3, 4, 5], lang="fr"), [5, 2, 4, 3, 1])

        def test_example_3_english(self) -> None:
            self.assertEqual(spellbound_sort([1, 2, 3, 4, 5]), [5, 4, 1, 3, 2])

        def test_example_4(self) -> None:
            self.assertEqual(spellbound_sort([0, -1, -2, -3, -4]), [-4, -1, -3, -2, 0])

        def test_example_5(self) -> None:
            self.assertEqual(spellbound_sort([100, 101, 102]), [100, 101, 102])

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge362Task2)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])
