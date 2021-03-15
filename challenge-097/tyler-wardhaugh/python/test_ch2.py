#!/usr/bin/env python3

import unittest
from ch2 import binary_substrings

class TestTask2(unittest.TestCase):


    def test_example_cases(self):
        self.assertEqual(1, binary_substrings('101100101', 3))
        self.assertEqual(2, binary_substrings('10110111', 4))


if __name__ == '__main__':
    unittest.main()
