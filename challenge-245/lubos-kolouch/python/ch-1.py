#!/usr/bin/env python3
"""Sort Language - Perl Weekly Challenge 245, Task 1."""

from __future__ import annotations

import unittest


def sort_language(langs: list[str], popularity: list[int]) -> list[str]:
    """Return languages sorted by ascending popularity."""
    combined = sorted(zip(langs, popularity, strict=True), key=lambda x: x[1])
    return [lang for lang, _ in combined]


class TestSortLanguage(unittest.TestCase):
    """Unit tests for the sort_language function."""

    def test_examples(self) -> None:
        """Verify all challenge examples."""
        cases: list[tuple[list[str], list[int], list[str]]] = [
            (["perl", "c", "python"], [2, 1, 3], ["c", "perl", "python"]),
            (["c++", "haskell", "java"], [1, 3, 2], ["c++", "java", "haskell"]),
        ]
        for langs, popularity, expected in cases:
            with self.subTest(langs=langs, popularity=popularity):
                self.assertEqual(sort_language(langs, popularity), expected)


if __name__ == "__main__":
    unittest.main()
