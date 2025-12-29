#!/usr/bin/env python3
"""Equal Strings - Perl Weekly Challenge 314 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def equal_strings_ops(s1: str, s2: str, s3: str) -> int:
    """
    Return minimum rightmost deletions to make all strings equal, or -1.

    Since we can only delete from the right, the only reachable common strings
    are common prefixes. The minimum operations uses the longest common prefix.
    """
    min_len = min(len(s1), len(s2), len(s3))
    idx = 0
    while idx < min_len and s1[idx] == s2[idx] == s3[idx]:
        idx += 1
    if idx == 0:
        return -1
    return (len(s1) - idx) + (len(s2) - idx) + (len(s3) - idx)


class EqualStringsExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(equal_strings_ops("abc", "abb", "ab"), 2)

    def test_example_2(self) -> None:
        self.assertEqual(equal_strings_ops("ayz", "cyz", "xyz"), -1)

    def test_example_3(self) -> None:
        self.assertEqual(equal_strings_ops("yza", "yzb", "yzc"), 3)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    if len(args) != 3:
        raise SystemExit("Usage: python3 ch-1.py <s1> <s2> <s3>")

    s1, s2, s3 = args
    print(f'Input: $s1 = "{s1}", $s2 = "{s2}", $s3 = "{s3}"')
    print(f"Output: {equal_strings_ops(s1, s2, s3)}")


if __name__ == "__main__":
    main()
