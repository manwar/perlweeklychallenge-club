#!/usr/bin/env python
# -*- coding: utf-8 -*-

import unittest


def divisible_pairs(lst, k):
    count = 0

    for i in range(len(lst) - 1):
        for j in range(i + 1, len(lst)):
            if (lst[i] + lst[j]) % k == 0:
                count += 1

    return count


class TestDivisiblePairs(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(divisible_pairs([4, 5, 1, 6], 2), 2)
        self.assertEqual(divisible_pairs([1, 2, 3, 4], 2), 2)
        self.assertEqual(divisible_pairs([1, 3, 4, 5], 3), 2)
        self.assertEqual(divisible_pairs([5, 1, 2, 3], 4), 2)
        self.assertEqual(divisible_pairs([7, 2, 4, 5], 4), 1)


if __name__ == '__main__':
    unittest.main()
