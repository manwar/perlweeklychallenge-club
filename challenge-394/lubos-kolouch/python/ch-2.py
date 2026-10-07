#!/usr/bin/env python3
"""Alternating Vowels Consonants - Perl Weekly Challenge 394 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def is_vowel(c: str) -> bool:
    """Return True if character is an English vowel, False otherwise."""
    return c.lower() in {"a", "e", "i", "o", "u"}


def is_alternating(sub: str) -> bool:
    """Return True if string strictly alternates between vowels and consonants."""
    if not sub:
        return False
    return all(is_vowel(sub[i]) != is_vowel(sub[i - 1]) for i in range(1, len(sub)))


def longest_alternating_common_substrings(strs: Sequence[str]) -> list[str]:
    """Find all longest contiguous alternating substrings common to all three strings."""
    if len(strs) != 3:
        raise ValueError("Exactly three strings are required")

    s1, s2, s3 = strs
    len1 = len(s1)
    valid_candidates: dict[str, int] = {}

    for i in range(len1):
        for length in range(1, len1 - i + 1):
            candidate = s1[i : i + length]
            if not is_alternating(candidate):
                break
            if candidate in s2 and candidate in s3:
                valid_candidates[candidate] = len(candidate)

    if not valid_candidates:
        return []

    max_len = max(valid_candidates.values())
    result: list[str] = []
    seen: set[str] = set()

    for i in range(len1 - max_len + 1):
        sub = s1[i : i + max_len]
        if (
            sub in valid_candidates
            and valid_candidates[sub] == max_len
            and sub not in seen
        ):
            result.append(sub)
            seen.add(sub)

    return result


class TestAlternatingVowelsConsonants(unittest.TestCase):
    """Unit tests for longest_alternating_common_substrings."""

    def test_example1(self) -> None:
        """Test example 1."""
        self.assertEqual(
            longest_alternating_common_substrings(["relocate", "delocate", "allocate"]),
            ["locate"],
        )

    def test_example2(self) -> None:
        """Test example 2."""
        self.assertEqual(
            longest_alternating_common_substrings(["apple", "banana", "cherry"]),
            [],
        )

    def test_example3(self) -> None:
        """Test example 3."""
        self.assertEqual(
            longest_alternating_common_substrings(["navigate", "cavity", "gravity"]),
            ["avi"],
        )

    def test_example4(self) -> None:
        """Test example 4."""
        self.assertEqual(
            longest_alternating_common_substrings(
                ["pedalgia", "pedalboard", "pedantic"]
            ),
            ["peda"],
        )

    def test_example5(self) -> None:
        """Test example 5."""
        self.assertEqual(
            longest_alternating_common_substrings(
                ["schoolmaster", "schoolhouse", "schooling"]
            ),
            ["ho", "ol"],
        )


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    if argv and len(argv) == 4:
        out = longest_alternating_common_substrings(argv[1:4])
        print(f"Output: ({', '.join(repr(x) for x in out)})")
        return
    unittest.main(argv=[sys.argv[0]])


if __name__ == "__main__":
    main(sys.argv)
