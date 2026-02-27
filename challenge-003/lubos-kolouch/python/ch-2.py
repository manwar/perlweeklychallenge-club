#!/usr/bin/env python3

"""Perl Weekly Challenge 003 Task 2: Pascal's Triangle."""

from __future__ import annotations

from collections.abc import Sequence


def generate_pascal_triangle(rows: int) -> list[list[int]]:
    """Return Pascal's triangle with the requested number of rows."""
    triangle: list[list[int]] = []
    for i in range(rows):
        row = [1]
        for j in range(1, i):
            row.append(triangle[i - 1][j - 1] + triangle[i - 1][j])
        if i > 0:
            row.append(1)
        triangle.append(row)
    return triangle


def _run_tests() -> None:
    import unittest

    class TestPascalTriangle(unittest.TestCase):
        def test_triangle_3(self) -> None:
            self.assertEqual(generate_pascal_triangle(3), [[1], [1, 1], [1, 2, 1]])

        def test_triangle_5(self) -> None:
            self.assertEqual(
                generate_pascal_triangle(5),
                [[1], [1, 1], [1, 2, 1], [1, 3, 3, 1], [1, 4, 6, 4, 1]],
            )

    suite = unittest.TestLoader().loadTestsFromTestCase(TestPascalTriangle)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    if len(argv) != 1:
        raise SystemExit(f"Usage: {__file__} <rows>")

    rows = int(argv[0])
    if rows < 3:
        raise SystemExit("Error: Pascal's Triangle must have at least 3 rows")

    triangle = generate_pascal_triangle(rows)
    print(f"Pascal's Triangle with {rows} rows:")
    for i in range(rows):
        padding = " " * (rows - i - 1)
        print(padding + " ".join(map(str, triangle[i])))


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])
