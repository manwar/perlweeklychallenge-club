#!/usr/bin/env python3
"""
Perl Weekly Challenge 098 - Task 1: Read N-characters

You are given a file path FILE.

Create a subroutine readN(FILE, number) that returns the next `number`
characters from the file and moves the pointer to the (n+1)th character,
so repeated calls continue where the previous call stopped.
"""

from __future__ import annotations

from typing import Dict, Sequence

_OFFSETS: Dict[str, int] = {}


def read_n(file_path: str, n: int) -> str:
    """Return next `n` characters from `file_path` keeping a per-file offset."""
    if n < 0:
        raise ValueError("n must be non-negative")

    offset = _OFFSETS.get(file_path, 0)
    with open(file_path, "r", encoding="utf-8") as handle:
        handle.seek(offset)
        chunk = handle.read(n)

    _OFFSETS[file_path] = offset + n
    return chunk


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    if len(argv) != 2:
        raise SystemExit(f"Usage: {__file__} <FILE> <n>")
    print(read_n(argv[0], int(argv[1])))


def _run_tests() -> None:
    import tempfile
    import unittest

    class TestChallenge098Task1(unittest.TestCase):
        def test_example(self) -> None:
            _OFFSETS.clear()
            with tempfile.NamedTemporaryFile("w+", encoding="utf-8", delete=True) as tf:
                tf.write("1234567890")
                tf.flush()

                self.assertEqual(read_n(tf.name, 4), "1234")
                self.assertEqual(read_n(tf.name, 4), "5678")
                self.assertEqual(read_n(tf.name, 4), "90")

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge098Task1)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

