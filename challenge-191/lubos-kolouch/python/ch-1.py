#!/usr/bin/env python
# -*- coding: utf-8 -*-

import unittest


def twice_largest(list_):
    max_val = max(list_)
    max_index = list_.index(max_val)

    # Check if the largest element is at least twice as large as each of the other items
    for i, val in enumerate(list_):
        if i != max_index and val * 2 > max_val:
            return -1

    return 1


class TestTwiceLargest(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(twice_largest([1, 2, 3, 4]), -1)
        self.assertEqual(twice_largest([1, 2, 0, 5]), 1)
        self.assertEqual(twice_largest([2, 6, 3, 1]), 1)
        self.assertEqual(twice_largest([4, 5, 2, 3]), -1)


if __name__ == '__main__':
    unittest.main()
