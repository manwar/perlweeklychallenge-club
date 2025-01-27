import unittest


def find_max_average(nums: list[int], n: int) -> float:
    """
    Find the maximum average of a contiguous subarray of length n.

    Args:
        nums (List[int]): List of integers
        n (int): Length of subarray to consider

    Returns:
        float: Maximum average of any contiguous subarray of length n

    Raises:
        ValueError: If n is greater than the length of nums or if nums is empty

    Examples:
        >>> find_max_average([1, 12, -5, -6, 50, 3], 4)
        12.75
        >>> find_max_average([5], 1)
        5.0
    """
    if not nums or n > len(nums):
        raise ValueError(
            "Invalid input: n must be <= length of nums and nums must not be empty"
        )

    # Calculate initial window sum
    window_sum = sum(nums[:n])
    max_sum = window_sum

    # Slide the window and update max_sum
    for i in range(n, len(nums)):
        window_sum = window_sum + nums[i] - nums[i - n]
        max_sum = max(max_sum, window_sum)

    return max_sum / n


class TestMaxAverage(unittest.TestCase):
    """Test cases for the maximum average problem"""

    def test_example_1(self):
        """Test case from Example 1"""
        self.assertEqual(find_max_average([1, 12, -5, -6, 50, 3], 4), 12.75)

    def test_example_2(self):
        """Test case from Example 2"""
        self.assertEqual(find_max_average([5], 1), 5.0)

    def test_edge_cases(self):
        """Test edge cases"""
        self.assertEqual(find_max_average([1, 2, 3], 3), 2.0)
        with self.assertRaises(ValueError):
            find_max_average([], 1)
        with self.assertRaises(ValueError):
            find_max_average([1, 2], 3)

    def test_negative_numbers(self):
        """Test with negative numbers"""
        self.assertEqual(find_max_average([-1, -2, -3, -4], 2), -1.5)

    def test_decimal_result(self):
        """Test case with decimal result"""
        self.assertEqual(find_max_average([1, 2, 3, 4, 5], 2), 4.5)


if __name__ == "__main__":
    import doctest
    doctest.testmod()
    unittest.main(verbosity=2)
