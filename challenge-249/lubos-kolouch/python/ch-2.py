#!/usr/bin/env python

import unittest
from typing import List


def di_string_match(s: str) -> list[int]:
    low, high = 0, len(s)
    perm = []

    for char in s:
        if char == "I":
            perm.append(low)
            low += 1
        else:
            perm.append(high)
            high -= 1

    perm.append(low)  # low == high at this point
    return perm


# Tests


class TestDIStringMatch(unittest.TestCase):
    def test_cases(self):
        self.assertEqual(di_string_match("IDID"), [0, 4, 1, 3, 2])
        self.assertEqual(di_string_match("III"), [0, 1, 2, 3])
        self.assertEqual(di_string_match("DDI"), [3, 2, 0, 1])


if __name__ == "__main__":
    unittest.main()
