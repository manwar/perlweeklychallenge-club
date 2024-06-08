""" Challenge 268 LK Task 2 Python """

from typing import List
import unittest


def number_game(ints: List[int]) -> List[int]:
    """
    Create a new array by repeatedly picking the two smallest integers
    from the input array and adding them to the new array in decreasing order.

    Args:
    ints (List[int]): The input list of integers.

    Returns:
    List[int]: The new list with elements added in the required order.
    """
    result = []
    while ints:
        # Find the two smallest integers
        min1 = min(ints)
        ints.remove(min1)
        min2 = min(ints)
        ints.remove(min2)

        # Add them to the result array in decreasing order
        result.extend([min2, min1])
    return result


# Unit tests
class TestNumberGame(unittest.TestCase):
    def test_example_1(self):
        self.assertEqual(number_game([2, 5, 3, 4]), [3, 2, 5, 4])

    def test_example_2(self):
        self.assertEqual(
            number_game([9, 4, 1, 3, 6, 4, 6, 1]), [1, 1, 4, 3, 6, 4, 9, 6]
        )

    def test_example_3(self):
        self.assertEqual(number_game([1, 2, 2, 3]), [2, 1, 3, 2])

    def test_already_sorted(self):
        self.assertEqual(number_game([1, 2, 3, 4, 5, 6]), [2, 1, 4, 3, 6, 5])

    def test_reverse_sorted(self):
        self.assertEqual(number_game([6, 5, 4, 3, 2, 1]), [2, 1, 4, 3, 6, 5])

    def test_duplicate_elements(self):
        self.assertEqual(number_game([5, 1, 5, 1, 2, 2]), [1, 1, 2, 2, 5, 5])


if __name__ == "__main__":
    unittest.main()
