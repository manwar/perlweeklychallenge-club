#!/usr/bin/env python
# -*- coding: utf-8 -*-

import unittest


def greater_character(arr, target):
    sorted_array = sorted(arr)

    for char in sorted_array:
        if char > target:
            return char

    return target  # Return the target character if no greater character is found


class TestGreaterCharacter(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(greater_character(['e', 'm', 'u', 'g'], 'b'), 'e')
        self.assertEqual(greater_character(['d', 'c', 'e', 'f'], 'a'), 'c')
        self.assertEqual(greater_character(['j', 'a', 'r'], 'o'), 'r')
        self.assertEqual(greater_character(['d', 'c', 'a', 'f'], 'a'), 'c')
        self.assertEqual(greater_character(['t', 'g', 'a', 'l'], 'v'), 'v')


if __name__ == '__main__':
    unittest.main()
