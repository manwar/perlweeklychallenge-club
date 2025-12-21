#!/usr/bin/env python3
"""Match String - Perl Weekly Challenge 352 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def match_string(words: Sequence[str]) -> list[str]:
    """
    Return words that occur as substrings of other words, in first-occurrence order.

    The examples show duplicate inputs (e.g. "dogcat" appearing twice) but only
    a single output occurrence, so results are de-duplicated while preserving
    order.
    """
    result: list[str] = []
    seen: set[str] = set()

    for idx, word in enumerate(words):
        if word in seen:
            continue
        seen.add(word)

        for other_idx, other in enumerate(words):
            if other_idx == idx:
                continue
            if word in other:
                result.append(word)
                break

    return result


class MatchStringExamples(unittest.TestCase):
    """Example-based tests from the challenge specification."""

    def test_example_1(self) -> None:
        self.assertEqual(
            match_string(
                (
                    "cat",
                    "cats",
                    "dog",
                    "dogcat",
                    "dogcat",
                    "rat",
                    "ratcatdogcat",
                )
            ),
            ["cat", "dog", "dogcat", "rat"],
        )

    def test_example_2(self) -> None:
        self.assertEqual(
            match_string(("hello", "hell", "world", "wor", "ellow", "elloworld")),
            ["hell", "world", "wor", "ellow"],
        )

    def test_example_3(self) -> None:
        self.assertEqual(match_string(("a", "aa", "aaa", "aaaa")), ["a", "aa", "aaa"])

    def test_example_4(self) -> None:
        self.assertEqual(
            match_string(("flower", "flow", "flight", "fl", "fli", "ig", "ght")),
            ["flow", "fl", "fli", "ig", "ght"],
        )

    def test_example_5(self) -> None:
        self.assertEqual(
            match_string(("car", "carpet", "carpenter", "pet", "enter", "pen", "pent")),
            ["car", "pet", "enter", "pen", "pent"],
        )


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    result = match_string(args)
    quoted_in = ", ".join(f'"{word}"' for word in args)
    quoted_out = ", ".join(f'"{word}"' for word in result)
    print(f"Input:  @words = ({quoted_in})")
    print(f"Output: ({quoted_out})")


if __name__ == "__main__":
    main()
