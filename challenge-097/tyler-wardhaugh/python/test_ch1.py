#!/usr/bin/env python3

import unittest
from ch1 import caesar

class TestTask1(unittest.TestCase):


    def test_example_cases(self):
        self.assertEqual(
                'QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD',
                caesar('THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG', 3))


if __name__ == '__main__':
    unittest.main()
