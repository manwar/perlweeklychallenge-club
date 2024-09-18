from typing import List
import unittest


def find_lucky_integer(ints: List[int]) -> int:
    """
    Finds the lucky integer in the given list of integers.

    A lucky integer is an integer whose frequency in the array is equal to its value.

    If there are multiple lucky integers, returns the largest one.
    If no lucky integers are found, returns -1.

    Args:
        ints (List[int]): A list of integers.

    Returns:
        int: The lucky integer if found, otherwise -1.
    """
    from collections import Counter
    freq = Counter(ints)
    lucky_integers = [num for num, count in freq.items() if num == count]
    if lucky_integers:
        return max(lucky_integers)
    else:
        return -1


# Unit Tests
class TestFindLuckyInteger(unittest.TestCase):

    def test_example1(self):
        self.assertEqual(find_lucky_integer([2, 2, 3, 4]), 2, 'Example 1')

    def test_example2(self):
        self.assertEqual(find_lucky_integer([1, 2, 2, 3, 3, 3]), 3,
                         'Example 2')

    def test_example3(self):
        self.assertEqual(find_lucky_integer([1, 1, 1, 3]), -1, 'Example 3')

    def test_additional(self):
        self.assertEqual(find_lucky_integer([5, 5, 5, 5, 5]), 5,
                         'All same number')
        self.assertEqual(find_lucky_integer([2, 2, 2, 3, 3]), -1,
                         'No lucky integer')
        self.assertEqual(find_lucky_integer([]), -1, 'Empty list')


if __name__ == "__main__":
    unittest.main()
