#!/usr/bin/env python3
"""
Perl Weekly Challenge 333, Task 2: Duplicate Zeros

Given an array of integers, duplicate each occurrence of zero, shifting the
remaining elements to the right. Elements beyond the original array length are
discarded.

Author: [Your Name]
"""
import unittest

IntArray = list[int]


def duplicate_zeros(ints: IntArray) -> IntArray:
    """
    Duplicate each zero in the array, shifting elements right within original length.

    Args:
        ints: List of integers.

    Returns:
        List[int]: Array with zeros duplicated, truncated to original length.
    """
    result = []
    for num in ints:
        if num == 0:
            if len(result) < len(ints):
                result.append(0)
            if len(result) < len(ints):
                result.append(0)
        else:
            if len(result) < len(ints):
                result.append(num)
    return result


# Unit Tests


class TestDuplicateZeros(unittest.TestCase):

    def test_example1(self):
        """Test case: Array (1,0,2,3,0,4,5,0) becomes (1,0,0,2,3,0,0,4)."""
        ints = [1, 0, 2, 3, 0, 4, 5, 0]
        expected = [1, 0, 0, 2, 3, 0, 0, 4]
        self.assertEqual(duplicate_zeros(ints), expected)

    def test_example2(self):
        """Test case: Array (1,2,3) remains (1,2,3)."""
        ints = [1, 2, 3]
        expected = [1, 2, 3]
        self.assertEqual(duplicate_zeros(ints), expected)

    def test_example3(self):
        """Test case: Array (1,2,3,0) remains (1,2,3,0)."""
        ints = [1, 2, 3, 0]
        expected = [1, 2, 3, 0]
        self.assertEqual(duplicate_zeros(ints), expected)

    def test_example4(self):
        """Test case: Array (0,0,1,2) becomes (0,0,0,0)."""
        ints = [0, 0, 1, 2]
        expected = [0, 0, 0, 0]
        self.assertEqual(duplicate_zeros(ints), expected)

    def test_example5(self):
        """Test case: Array (1,2,0,3,4) becomes (1,2,0,0,3)."""
        ints = [1, 2, 0, 3, 4]
        expected = [1, 2, 0, 0, 3]
        self.assertEqual(duplicate_zeros(ints), expected)


if __name__ == '__main__':
    unittest.main()
