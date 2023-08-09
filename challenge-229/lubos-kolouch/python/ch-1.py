#!/usr/bin/env python
# -*- coding: utf-8 -*-
import unittest
from typing import List


def count_deletions(strings: List[str]) -> int:
    return sum(1 for s in strings if s != ''.join(sorted(s)) and s != ''.join(sorted(s, reverse=True)))


class TestCountDeletions(unittest.TestCase):
    def test_case_1(self):
        self.assertEqual(count_deletions(["abc", "bce", "cae"]), 1)

    def test_case_2(self):
        self.assertEqual(count_deletions(["yxz", "cba", "mon"]), 2)


if __name__ == '__main__':
    unittest.main()
