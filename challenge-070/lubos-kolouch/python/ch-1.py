#!/usr/bin/env python3
"""
Perl Weekly Challenge 070 - Task 1: Character Swapping

Given a string $S of size $N, swap count $C, and offset $O,
perform character swapping for $i = 1 .. $C at positions
$i % $N and ($i + $O) % $N.
"""

import unittest


def swap_chars(s: str, c: int, o: int) -> str:
    """Perform character swapping according to the challenge rules."""
    chars = list(s)
    n = len(chars)
    if n == 0:
        return ""

    for i in range(1, c + 1):
        x = i % n
        y = (i + o) % n
        chars[x], chars[y] = chars[y], chars[x]

    return "".join(chars)


class TestCharacterSwapping(unittest.TestCase):
    def test_example(self) -> None:
        self.assertEqual(swap_chars("perlandraku", 3, 4), "pndraerlaku")

    def test_single_char(self) -> None:
        self.assertEqual(swap_chars("a", 3, 4), "a")

    def test_zero_swaps(self) -> None:
        self.assertEqual(swap_chars("perlandraku", 0, 4), "perlandraku")


if __name__ == "__main__":
    unittest.main()
