#!/usr/bin/env python3

import unittest
from ch2 import search_insert_position

class TestTask2(unittest.TestCase):


    def test_example_cases(self):
        self.assertEqual(2, search_insert_position([1, 2, 3, 4], 3))
        self.assertEqual(3, search_insert_position([1, 3, 5, 7], 6))
        self.assertEqual(0, search_insert_position([12, 14, 16, 18], 10))
        self.assertEqual(4, search_insert_position([11, 13, 15, 17], 19))


if __name__ == '__main__':
    unittest.main()
