#!/usr/bin/env python

import unittest


def divide_groups(text: str, size: int, filler: str) -> list[str]:
    """
    Divide a string into equal-sized groups, padding the last one if needed.

    Args:
        text: The string to divide.
        size: The size of each group.
        filler: The character to use for padding.

    Returns:
        A list of group strings.
    """

    if not text:
        return [filler * size]

    # Calculate padding
    remainder = len(text) % size
    if remainder > 0:
        text += filler * (size - remainder)

    # Split into groups
    groups = [text[i : i + size] for i in range(0, len(text), size)]

    return groups


class TestDivideGroups(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(divide_groups("RakuPerl", 4, "*"), ["Raku", "Perl"])
        self.assertEqual(divide_groups("Python", 5, "0"), ["Pytho", "n0000"])
        self.assertEqual(divide_groups("12345", 3, "x"), ["123", "45x"])
        self.assertEqual(
            divide_groups("HelloWorld", 3, "_"), ["Hel", "loW", "orl", "d__"]
        )
        self.assertEqual(divide_groups("AI", 5, "!"), ["AI!!!"])
        self.assertEqual(divide_groups("", 3, "~"), ["~~~"])


if __name__ == "__main__":
    unittest.main()
