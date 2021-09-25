#!/usr/bin/env python3
"""Test Task 1"""

import unittest
from ch1 import consecutive_arrays


class TestTask1(unittest.TestCase):
    """Test Task 1"""

    def test_example_cases(self):
        """Test Task 1"""
        self.assertEqual([[1, 2, 3], [6, 7, 8, 9]],
                consecutive_arrays([1, 2, 3, 6, 7, 8, 9]))
        self.assertEqual([[11, 12], [14], [17, 18, 19]],
                consecutive_arrays([11, 12, 14, 17, 18, 19]))
        self.assertEqual([[2], [4], [6], [8]],
                consecutive_arrays([2, 4, 6, 8]))
        self.assertEqual([[1, 2, 3, 4, 5]],
                consecutive_arrays([1, 2, 3, 4, 5]))



if __name__ == '__main__':
    unittest.main()
