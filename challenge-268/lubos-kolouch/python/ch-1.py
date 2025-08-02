""" Challenge 268 LK Task 1 Python """

from typing import List
import unittest

# Type definition for clarity
IntList = List[int]


def arrays_are_equal(a: IntList, b: IntList) -> bool:
    """Check if two lists contain the same elements in any order."""
    return sorted(a) == sorted(b)


def find_magic_number(x: IntList, y: IntList) -> int:
    """
    Find the magic number that, when added to each element of x, gives the elements of y.

    Args:
    x (IntList): The first list of integers.
    y (IntList): The second list of integers.

    Returns:
    int: The magic number.

    Raises:
    ValueError: If no magic number is found or input arrays are invalid.
    """
    if len(x) != len(y):
        raise ValueError("Input arrays must be of the same size")
    if not x or not y:
        raise ValueError("Input arrays must not be empty")

    possible_candidates = set()
    for i in range(len(x)):
        for j in range(len(y)):
            possible_candidates.add(y[j] - x[i])

    for candidate in possible_candidates:
        transformed_x = [xi + candidate for xi in x]
        if arrays_are_equal(transformed_x, y):
            return candidate

    raise ValueError("No magic number found")


# Unit tests
class TestMagicNumber(unittest.TestCase):
    def test_example_1(self):
        self.assertEqual(find_magic_number([3, 7, 5], [9, 5, 7]), 2)

    def test_example_2(self):
        self.assertEqual(find_magic_number([1, 2, 1], [5, 4, 4]), 3)

    def test_example_3(self):
        self.assertEqual(find_magic_number([2], [5]), 3)

    def test_different_size(self):
        with self.assertRaises(ValueError):
            find_magic_number([1, 2, 3], [4, 5])

    def test_empty_arrays(self):
        with self.assertRaises(ValueError):
            find_magic_number([], [])

    def test_no_magic_number(self):
        with self.assertRaises(ValueError):
            find_magic_number([1, 2, 3], [10, 20, 30])


if __name__ == "__main__":
    unittest.main()
