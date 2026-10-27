"""Task 1: Double Exist.

Check if there exist two indices i and j such that i != j and
ints[i] == 2 * ints[j].
"""

import unittest


def double_exist(ints: list[int]) -> bool:
    """Check if there exist two indices i and j in the list such that:

    1) i != j
    2) 0 <= i, j < len(ints)
    3) ints[i] == 2 * ints[j]

    Args:
        ints: A list of integers.

    Returns:
        bool: True if such indices exist, False otherwise.
    """
    seen: set[int] = set()
    for num in ints:
        if num == 0:
            if 0 in seen:
                return True
        else:
            if num * 2 in seen or (num % 2 == 0 and num // 2 in seen):
                return True
        seen.add(num)
    return False


class TestDoubleExist(unittest.TestCase):
    """Unit tests for double_exist."""

    def test_example1(self) -> None:
        """Test with example 1."""
        self.assertEqual(double_exist([6, 2, 3, 3]), True, "Example 1")

    def test_example2(self) -> None:
        """Test with example 2."""
        self.assertEqual(double_exist([3, 1, 4, 13]), False, "Example 2")

    def test_example3(self) -> None:
        """Test with example 3."""
        self.assertEqual(double_exist([2, 1, 4, 2]), True, "Example 3")

    def test_with_zero(self) -> None:
        """Test with zeros."""
        self.assertEqual(double_exist([0, 0]), True, "Zero case")

    def test_negative_numbers(self) -> None:
        """Test with negative numbers."""
        self.assertEqual(double_exist([-2, -1, -4, -2]), True, "Negative numbers")

    def test_no_pair(self) -> None:
        """Test when no pair exists."""
        self.assertEqual(double_exist([1, 3, 5, 7]), False, "No pair exists")


if __name__ == "__main__":
    unittest.main()
