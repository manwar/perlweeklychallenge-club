#!/usr/bin/env python3

import unittest
from ch2 import min_triangle_sum

class TestTask2(unittest.TestCase):


    def test_example_cases(self):
        self.assertEqual(8, min_triangle_sum([ [1], [2,4], [6,4,9], [5,1,7,2] ]))
        self.assertEqual(7, min_triangle_sum([ [3], [3,1], [5,2,3], [4,3,1,3] ]))


if __name__ == '__main__':
    unittest.main()
