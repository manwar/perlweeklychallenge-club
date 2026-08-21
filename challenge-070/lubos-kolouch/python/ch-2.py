#!/usr/bin/env python3
"""
Perl Weekly Challenge 070 - Task 2: Gray Code Sequence

Generate an N-bit Gray code sequence, represented as decimal integers.
"""

import unittest


def gray_code_sequence(n: int) -> list[int]:
    """Generate an N-bit Gray code sequence as decimal integers."""
    if n <= 0:
        return [0]

    gray_code = ["0", "1"]

    for _ in range(2, n + 1):
        rev_gray_code = gray_code[::-1]
        gray_code = ["0" + x for x in gray_code]
        rev_gray_code = ["1" + x for x in rev_gray_code]
        gray_code += rev_gray_code

    return [int(x, 2) for x in gray_code]


class TestGrayCodeSequence(unittest.TestCase):
    def test_n_4(self) -> None:
        self.assertEqual(
            gray_code_sequence(4),
            [0, 1, 3, 2, 6, 7, 5, 4, 12, 13, 15, 14, 10, 11, 9, 8],
        )

    def test_n_3(self) -> None:
        self.assertEqual(
            gray_code_sequence(3),
            [0, 1, 3, 2, 6, 7, 5, 4],
        )

    def test_n_1(self) -> None:
        self.assertEqual(gray_code_sequence(1), [0, 1])


if __name__ == "__main__":
    unittest.main()
