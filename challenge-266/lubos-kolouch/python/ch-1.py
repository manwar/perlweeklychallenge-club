#!/usr/bin/env python3
"""Uncommon Words - The Weekly Challenge 266 Task 1."""

from __future__ import annotations

from collections import Counter
from collections.abc import Sequence
import sys
import unittest


def uncommon_words(line1: str, line2: str) -> tuple[str, ...]:
    """Find all uncommon words in any order in the given two sentences.

    A word is uncommon if it appears exactly once in one sentence
    and does not appear in the other sentence. Returns ('',) if none found.

    Args:
        line1: The first sentence.
        line2: The second sentence.

    Returns:
        A tuple of uncommon words, or ('',) if no uncommon words are found.
    """
    words1 = line1.split()
    words2 = line2.split()

    counter1 = Counter(words1)
    counter2 = Counter(words2)

    uncommon: list[str] = [
        word for word in counter1 if counter1[word] == 1 and word not in counter2
    ]
    for word in counter2:
        if counter2[word] == 1 and word not in counter1:
            uncommon.append(word)

    return tuple(uncommon) if uncommon else ("",)


class TestUncommonWords(unittest.TestCase):
    """Unit tests for uncommon_words."""

    def test_example1(self) -> None:
        """Test Example 1: 'Mango is sweet' and 'Mango is sour'."""
        self.assertEqual(
            uncommon_words("Mango is sweet", "Mango is sour"),
            ("sweet", "sour"),
        )

    def test_example2(self) -> None:
        """Test Example 2: 'Mango Mango' and 'Orange'."""
        self.assertEqual(
            uncommon_words("Mango Mango", "Orange"),
            ("Orange",),
        )

    def test_example3(self) -> None:
        """Test Example 3: 'Mango is Mango' and 'Orange is Orange'."""
        self.assertEqual(
            uncommon_words("Mango is Mango", "Orange is Orange"),
            ("",),
        )

    def test_empty_sentences(self) -> None:
        """Test empty sentences."""
        self.assertEqual(
            uncommon_words("", ""),
            ("",),
        )


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    if argv and len(argv) > 2:
        print(f"Output: {uncommon_words(argv[1], argv[2])}")
        return
    unittest.main(argv=[sys.argv[0]])


if __name__ == "__main__":
    main(sys.argv)
