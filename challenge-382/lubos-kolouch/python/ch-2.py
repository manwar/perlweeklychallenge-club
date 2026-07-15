#!/usr/bin/env python3
"""Replace Question Mark - Perl Weekly Challenge 382 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def replace_question_marks(str_val: str) -> list[str]:
    """Replace all '?' with '0' or '1' and return sorted list of possible combinations."""
    results: list[str] = []

    def helper(s: str, idx: int) -> None:
        if idx == len(s):
            results.append(s)
            return

        if s[idx] == "?":
            helper(s[:idx] + "0" + s[idx + 1 :], idx + 1)
            helper(s[:idx] + "1" + s[idx + 1 :], idx + 1)
        else:
            helper(s, idx + 1)

    helper(str_val, 0)
    return sorted(results)


class ReplaceQuestionMarksExamples(unittest.TestCase):
    def test_example_1(self) -> None:
        self.assertEqual(
            replace_question_marks("01??0"), ["01000", "01010", "01100", "01110"]
        )

    def test_example_2(self) -> None:
        self.assertEqual(replace_question_marks("101"), ["101"])

    def test_example_3(self) -> None:
        self.assertEqual(
            replace_question_marks("???"),
            ["000", "001", "010", "011", "100", "101", "110", "111"],
        )

    def test_example_4(self) -> None:
        self.assertEqual(replace_question_marks("1?10"), ["1010", "1110"])

    def test_example_5(self) -> None:
        self.assertEqual(
            replace_question_marks("1?1?0"),
            ["10100", "10110", "11100", "11110"],
        )


def main(argv: Sequence[str] | None = None) -> None:
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    raise SystemExit(
        "Usage: python3 ch-2.py\n(Run with no arguments to execute the unit tests)"
    )


if __name__ == "__main__":
    main()
