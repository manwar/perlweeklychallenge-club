#!/usr/bin/env python3
from __future__ import annotations

import unittest

from typing import List

class TestGreatestChar(unittest.TestCase):
    def test_greatest_char(self):
        test = [
                [['e', 'u', 'm', 'g'], 'b'],
                [['d', 'c', 'e', 'f'], 'a'],
                [['d', 'c', 'a', 'f'], 'a'],
                [['t', 'g', 'a', 'l'], 'v'],
                [['j', 'a', 'r'], 'o']
                ] 
        self.assertEqual(greatest_char(test[0][0], test[0][1]), 'e')
        self.assertEqual(greatest_char(test[1][0], test[1][1]), 'c')
        self.assertEqual(greatest_char(test[2][0], test[2][1]), 'c')
        self.assertEqual(greatest_char(test[3][0], test[3][1]), 'v')
        self.assertEqual(greatest_char(test[4][0], test[4][1]), 'r')

def greatest_char(l: List[str], tgt: str) -> str:
    smallest = min(l)
    biggest  = max(l)
    if smallest == tgt:
        _sorted = sorted(l)[1:]
        smallerer = min(_sorted)
        return smallerer
    elif smallest > tgt:
        return smallest
    elif biggest > tgt:
        return biggest
    else:
        return tgt

if __name__ == "__main__":
    unittest.main()


