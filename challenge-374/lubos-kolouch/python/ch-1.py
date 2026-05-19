#!/usr/bin/env python3
"""Count Vowel - Perl Weekly Challenge 374 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def count_vowel(text: str) -> list[str]:
    """Return all vowel substrings containing all five vowels."""
    vowels = set("aeiou")
    results = []
    chars = list(text)
    for i in range(len(chars)):
        if chars[i] not in vowels:
            continue
        seen: set[str] = set()
        for j in range(i, len(chars)):
            if chars[j] not in vowels:
                break
            seen.add(chars[j])
            if len(seen) == 5:
                results.append("".join(chars[i : j + 1]))
    return results


class CountVowelExamples(unittest.TestCase):
    def test_example_1(self) -> None:
        self.assertEqual(count_vowel("aeiou"), ["aeiou"])

    def test_example_2(self) -> None:
        self.assertEqual(
            count_vowel("aaeeeiioouu"),
            ["aaeeeiioou", "aaeeeiioouu", "aeeeiioou", "aeeeiioouu"],
        )

    def test_example_3(self) -> None:
        self.assertEqual(
            count_vowel("aeiouuaxaeiou"),
            ["aeiou", "aeiouu", "aeiouua", "eiouua", "aeiou"],
        )

    def test_example_4(self) -> None:
        self.assertEqual(count_vowel("uaeiou"), ["uaeio", "uaeiou", "aeiou"])

    def test_example_5(self) -> None:
        self.assertEqual(count_vowel("aeioaeioa"), [])


def main(argv: Sequence[str] | None = None) -> None:
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    if len(args) != 1:
        raise SystemExit("Usage: python3 ch-1.py <string>")
    text = args[0]
    result = count_vowel(text)
    print(f'Input: $str = "{text}"')
    print(f"Output: ({', '.join(repr(s) for s in result)})")


if __name__ == "__main__":
    main()
