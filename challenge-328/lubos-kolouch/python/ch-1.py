#!/usr/bin/env python3
"""
Task: Replace all ? (Weekly Challenge 328)

Replace every '?' in a lowercase string with a letter so that no two
consecutive characters match. Any valid result is acceptable.
"""
from __future__ import annotations

import string
import unittest


def replace_question_marks(text: str) -> str:
    """Replace '?' ensuring no identical adjacent characters."""
    chars = list(text)
    for i, ch in enumerate(chars):
        if ch != "?":
            continue
        prev_ch = chars[i - 1] if i > 0 else ""
        next_ch = chars[i + 1] if i < len(chars) - 1 else ""
        for cand in string.ascii_lowercase:
            if cand != prev_ch and cand != next_ch:
                chars[i] = cand
                break
    return "".join(chars)


class ReplaceQuestionMarksTests(unittest.TestCase):
    def test_examples(self) -> None:
        self.assertRegex(replace_question_marks("a?z"), r"^a.z$")
        self.assertEqual(replace_question_marks("pe?k"), "peak")
        self.assertRegex(replace_question_marks("gra?te"), r"^gra.te$")


if __name__ == "__main__":
    unittest.main()
