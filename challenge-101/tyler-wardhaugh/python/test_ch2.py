#!/usr/bin/env python3
"""Test Task 2"""

import unittest
from ch2 import contains_origin


class TestTask2(unittest.TestCase):
    """Test Task 2"""

    def test_example_cases(self):
        """Test Task 2"""
        self.assertFalse(contains_origin([[0, 1], [1, 0], [2, 2]]))
        self.assertTrue(contains_origin([[1, 1], [-1, 1], [0, -3]]))
        self.assertTrue(contains_origin([[0, 1], [2, 0], [-6, 0]]))


if __name__ == '__main__':
    unittest.main()
