#!/usr/bin/env python3

import unittest
from ch2 import unique_subsequences

class TestTask2(unittest.TestCase):


    def test_example_cases(self):
        self.assertEqual(5, unique_subsequences('littleit', 'lit'))
        self.assertEqual(3, unique_subsequences('london', 'lon'))


if __name__ == '__main__':
    unittest.main()
