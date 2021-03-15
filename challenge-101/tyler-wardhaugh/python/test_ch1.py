#!/usr/bin/env python3
"""Test Task 1"""

import unittest
from ch1 import pack_spiral


class TestTask1(unittest.TestCase):
    """Test Task 1"""

    def test_example_cases(self):
        """Test Task 1"""
        self.assertEqual([[4, 3], [1, 2]],
                         pack_spiral(list(range(1, 5))))
        self.assertEqual([[6, 5, 4], [1, 2, 3]],
                         pack_spiral(list(range(1, 7))))
        self.assertEqual([[9, 8, 7, 6], [10, 11, 12, 5], [1, 2, 3, 4]],
                         pack_spiral(list(range(1, 13))))


if __name__ == '__main__':
    unittest.main()
