import unittest
from typing import List


def third_distinct_maximum(ints: list[int]) -> int:
    """
    Finds the third distinct maximum number in the given list of integers.
    If the third maximum doesn't exist, returns the maximum number.

    Args:
        ints (List[int]): A list of integers.

    Returns:
        int: The third distinct maximum if it exists, otherwise the maximum number.
    """
    distinct_ints = sorted(set(ints), reverse=True)
    if len(distinct_ints) >= 3:
        return distinct_ints[2]
    else:
        return distinct_ints[0]


# Unit Tests
class TestThirdDistinctMaximum(unittest.TestCase):
    def test_example1(self):
        self.assertEqual(third_distinct_maximum([5, 6, 4, 1]), 4, "Example 1")

    def test_example2(self):
        self.assertEqual(third_distinct_maximum([4, 5]), 5, "Example 2")

    def test_example3(self):
        self.assertEqual(third_distinct_maximum([1, 2, 2, 3]), 1, "Example 3")

    def test_with_duplicates(self):
        self.assertEqual(third_distinct_maximum([2, 2, 3, 1]), 1, "With duplicates")

    def test_negative_numbers(self):
        self.assertEqual(
            third_distinct_maximum([-1, -2, -3, -4]), -3, "Negative numbers"
        )

    def test_all_same(self):
        self.assertEqual(third_distinct_maximum([1, 1, 1]), 1, "All same numbers")


if __name__ == "__main__":
    unittest.main()
