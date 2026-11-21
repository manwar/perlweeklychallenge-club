#!/usr/bin/env python3
"""Longest Absolute Path - Perl Weekly Challenge 399, Task 2."""

from __future__ import annotations

import unittest


def longest_absolute_path(fs: str) -> int:
    """Return the length of the longest absolute file path, or 0 if none."""
    depth_len: dict[int, int] = {}
    max_len = 0

    for line in fs.split("\n"):
        name = line.lstrip("\t")
        depth = len(line) - len(name)
        cur_len = (0 if depth == 0 else depth_len[depth - 1] + 1) + len(name)
        depth_len[depth] = cur_len

        if "." in name:
            max_len = max(max_len, cur_len)

    return max_len


class TestLongestAbsolutePath(unittest.TestCase):
    """Unit tests for the longest_absolute_path function."""

    def test_examples(self) -> None:
        """Verify all challenge examples."""
        cases: list[tuple[str, int]] = [
            ("dir\n\tsubdir1\n\t\tsubsubdir1\n\tsubdir2", 0),
            ("file1.txt\nfile2.ext\na.png", 9),
            ("my documents\n\tproject v1.0\n\t\tnotes v1.txt\n\timage.png", 38),
            ("root\n\ta\n\t\tb\n\t\t\tc.txt\n\td\n\t\te.txt", 14),
            (
                "a\n\tb\n\t\tc\n\t\t\td\n\t\t\t\te.txt\n\tvery_long_directory_name\n\t\tf.txt",
                32,
            ),
        ]
        for fs, expected in cases:
            with self.subTest(fs=fs):
                self.assertEqual(longest_absolute_path(fs), expected)


if __name__ == "__main__":
    unittest.main()
