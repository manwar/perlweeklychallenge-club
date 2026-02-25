#!/usr/bin/env python3
"""
Perl Weekly Challenge 033 - Task 2: Formatted Multiplication Table

Print 11x11 multiplication table, top-half triangle.
"""

from __future__ import annotations

from typing import Sequence


def render_table(size: int = 11) -> str:
    """Return the top-half triangular multiplication table text."""
    header = "  x|" + "".join(f"{n:>4}" for n in range(1, size + 1))
    sep = "---+" + "-" * (4 * size)
    lines = [header, sep]

    for row in range(1, size + 1):
        cells = []
        for col in range(1, size + 1):
            if col < row:
                cells.append(" " * 4)
            else:
                cells.append(f"{row * col:>4}")
        lines.append(f"{row:>3}|" + "".join(cells))

    return "\n".join(lines)


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    raise SystemExit("Run without arguments to execute embedded tests.")


def _run_tests() -> None:
    import unittest

    class TestChallenge033Task2(unittest.TestCase):
        def test_expected_output(self) -> None:
            expected = "\n".join(
                [
                    "  x|   1   2   3   4   5   6   7   8   9  10  11",
                    "---+--------------------------------------------",
                    "  1|   1   2   3   4   5   6   7   8   9  10  11",
                    "  2|       4   6   8  10  12  14  16  18  20  22",
                    "  3|           9  12  15  18  21  24  27  30  33",
                    "  4|              16  20  24  28  32  36  40  44",
                    "  5|                  25  30  35  40  45  50  55",
                    "  6|                      36  42  48  54  60  66",
                    "  7|                          49  56  63  70  77",
                    "  8|                              64  72  80  88",
                    "  9|                                  81  90  99",
                    " 10|                                     100 110",
                    " 11|                                         121",
                ]
            )
            self.assertEqual(render_table(), expected)

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge033Task2)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])
