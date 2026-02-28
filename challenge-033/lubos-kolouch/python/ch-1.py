#!/usr/bin/env python3
"""
Perl Weekly Challenge 033 - Task 1: Count Letters (A..Z)

Count occurrences of letters a..z across one or more files.
"""

from __future__ import annotations

from collections import Counter
from pathlib import Path
from typing import Iterable, Sequence


def count_letters(texts: Iterable[str]) -> dict[str, int]:
    """Return lowercase letter frequencies for a..z."""
    counts: Counter[str] = Counter()
    for text in texts:
        for ch in text.lower():
            if "a" <= ch <= "z":
                counts[ch] += 1
    return {chr(code): counts.get(chr(code), 0) for code in range(ord("a"), ord("z") + 1)}


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return

    texts = [Path(path).read_text(encoding="utf-8") for path in argv]
    result = count_letters(texts)
    for letter in (chr(code) for code in range(ord("a"), ord("z") + 1)):
        print(f"{letter}:{result[letter]}")


def _run_tests() -> None:
    import unittest

    class TestChallenge033Task1(unittest.TestCase):
        def test_sample_sentence(self) -> None:
            sample = "The quick brown fox jumps over the lazy dog."
            expected = {
                "a": 1,
                "b": 1,
                "c": 1,
                "d": 1,
                "e": 3,
                "f": 1,
                "g": 1,
                "h": 2,
                "i": 1,
                "j": 1,
                "k": 1,
                "l": 1,
                "m": 1,
                "n": 1,
                "o": 4,
                "p": 1,
                "q": 1,
                "r": 2,
                "s": 1,
                "t": 2,
                "u": 2,
                "v": 1,
                "w": 1,
                "x": 1,
                "y": 1,
                "z": 1,
            }
            self.assertEqual(count_letters([sample]), expected)

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge033Task1)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])
