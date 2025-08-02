"""Module for finding the element after which the smallest gap occurs in an array.

This module provides the `min_gap` function which, given an array of integers in increasing
order, returns the element immediately after the smallest difference (gap) between consecutive elements.

If there are fewer than two elements in the array, the function returns None.

Example:
    Given the array [2, 8, 10, 11, 15], the gaps are:
        8 - 2   => 6
        10 - 8  => 2
        11 - 10 => 1
        15 - 11 => 4

    The smallest gap is 1 (before 11), so the function returns 11.
"""

from typing import Optional

# Type alias for a list of integers
IntList = list[int]


def min_gap(arr: IntList) -> Optional[int]:
    """
    Return the element after which the smallest gap occurs.

    For an array [a, b, c, ...], the gap is defined as:
        gap = current_element - previous_element.

    The function returns the element appearing immediately after the smallest gap.
    In case of a tie, the first occurrence is returned.
    If the array has fewer than two elements, None is returned.

    :param arr: A list of integers in increasing order.
    :return: The element after which the smallest gap is observed, or None if not applicable.
    """
    if len(arr) < 2:
        return None  # Not enough elements to form a gap

    min_delta = float('inf')
    candidate: Optional[int] = None

    # Loop from the second element to the end to calculate gaps
    for i in range(1, len(arr)):
        diff = arr[i] - arr[i - 1]
        if diff < min_delta:
            min_delta = diff
            candidate = arr[i]

    return candidate


if __name__ == '__main__':
    import unittest

    class TestMinGap(unittest.TestCase):

        def test_basic_example1(self):
            """Test using the first example from the challenge."""
            self.assertEqual(min_gap([2, 8, 10, 11, 15]), 11)

        def test_basic_example2(self):
            """Test using the second example from the challenge."""
            self.assertEqual(min_gap([1, 5, 6, 7, 14]), 6)

        def test_basic_example3(self):
            """Test using the third example from the challenge."""
            self.assertEqual(min_gap([8, 20, 25, 28]), 28)

        def test_empty_array(self):
            """Test that an empty array returns None."""
            self.assertIsNone(min_gap([]))

        def test_single_element(self):
            """Test that an array with a single element returns None."""
            self.assertIsNone(min_gap([42]))

        def test_tied_gaps(self):
            """
            Test when two or more gaps have the same smallest value.
            The function should return the candidate corresponding to the first occurrence.
            """
            # For [1, 3, 5, 6, 9]:
            # Gaps: 3-1=2, 5-3=2, 6-5=1, 9-6=3; smallest gap is 1 (before 6)
            self.assertEqual(min_gap([1, 3, 5, 6, 9]), 6)
            # For [1, 2, 3, 4]:
            # All gaps are 1; return candidate corresponding to the first gap, which is 2.
            self.assertEqual(min_gap([1, 2, 3, 4]), 2)

    unittest.main()
