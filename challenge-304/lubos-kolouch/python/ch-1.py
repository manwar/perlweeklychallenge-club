import unittest


def can_arrange_binary(digits: list[int], n: int) -> bool:
    """
    Determine if a list of binary digits can be rearranged by replacing at least n 0s with 1s
    such that no two consecutive digits are 1.

    Args:
        digits (List[int]): List of binary digits (0s and 1s)
        n (int): Number of digits that must be replaced with 1

    Returns:
        bool: True if arrangement is possible, False otherwise

    Examples:
        >>> can_arrange_binary([1, 0, 0, 0, 1], 1)
        True
        >>> can_arrange_binary([1, 0, 0, 0, 1], 2)
        False
    """
    # Count existing 1s
    ones_count = sum(digits)

    # Calculate maximum possible 1s that can be placed without being adjacent
    max_possible_ones = (len(digits) + 1) // 2

    # Calculate total 1s after adding n more
    total_ones = ones_count + n

    # If total ones needed exceeds maximum possible ones, return False
    return total_ones <= max_possible_ones


class TestArrangeBinary(unittest.TestCase):
    """Test cases for the binary arrangement problem"""

    def test_example_1(self):
        """Test case from Example 1"""
        self.assertTrue(can_arrange_binary([1, 0, 0, 0, 1], 1))

    def test_example_2(self):
        """Test case from Example 2"""
        self.assertFalse(can_arrange_binary([1, 0, 0, 0, 1], 2))

    def test_empty_list(self):
        """Test with empty list"""
        self.assertTrue(can_arrange_binary([], 0))

    def test_single_element(self):
        """Test with single element"""
        self.assertTrue(can_arrange_binary([0], 1))
        self.assertTrue(can_arrange_binary([1], 0))

    def test_all_zeros(self):
        """Test with all zeros"""
        self.assertTrue(can_arrange_binary([0, 0, 0, 0], 2))
        self.assertFalse(can_arrange_binary([0, 0, 0, 0], 3))

    def test_all_ones(self):
        """Test with all ones"""
        self.assertFalse(can_arrange_binary([1, 1, 1, 1], 0))


if __name__ == "__main__":
    import doctest
    doctest.testmod()
    unittest.main(verbosity=2)
