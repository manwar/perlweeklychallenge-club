#!/usr/bin/env python
# -*- coding: utf-8 -*-

import unittest
from typing import List


def number_collision(numbers: List[int]) -> List[int]:
    positive = sorted([n for n in numbers if n > 0])
    negative = sorted([abs(n) for n in numbers if n < 0])

    while positive and negative:
        if positive[0] < negative[0]:
            positive.pop(0)
        elif positive[0] > negative[0]:
            negative.pop(0)
        else:
            positive.pop(0)
            negative.pop(0)

    return positive + [-n for n in negative]


class TestNumberCollision(unittest.TestCase):

    def test_case_1(self):
        self.assertEqual(number_collision([2, 3, -1]), [2, 3])

    def test_case_2(self):
        self.assertEqual(number_collision([3, 2, -4]), [-4])

    def test_case_3(self):
        self.assertEqual(number_collision([1, -1]), [])


if __name__ == "__main__":
    unittest.main()
